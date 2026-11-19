using Bookstore.Domain.Entities;
using Bookstore.Domain.Enums;
using Bookstore.Infrastructure.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace Bookstore.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class OrdersController : ControllerBase
{
    private readonly BookstoreDbContext _context;

    public OrdersController(BookstoreDbContext context)
    {
        _context = context;
    }

    private const int PointValue = 100; // VND per point

    // Earn 1 point per 1.000 VND of delivered orders; spend via checkout
    private async Task<(int earned, int used, int balance)> GetLoyaltyAsync(int userId)
    {
        var amounts = await _context.Orders
            .Where(o => o.UserId == userId && o.Status == OrderStatus.Delivered)
            .Select(o => o.FinalAmount)
            .ToListAsync();
        var earned = amounts.Sum(a => (int)Math.Floor(a / 1000m));
        var used = (await _context.Users.FindAsync(userId))?.PointsUsed ?? 0;
        return (earned, used, Math.Max(0, earned - used));
    }

    [HttpGet("loyalty")]
    [Authorize]
    public async Task<IActionResult> GetLoyalty()
    {
        var idClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (!int.TryParse(idClaim, out var userId)) return Unauthorized();
        var (earned, used, balance) = await GetLoyaltyAsync(userId);
        return Ok(new { earned, used, balance, pointValue = PointValue });
    }

    [HttpPost]
    [Authorize]
    public async Task<IActionResult> CreateOrder([FromBody] CreateOrderRequest request)
    {
        var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (string.IsNullOrEmpty(userIdClaim) || !int.TryParse(userIdClaim, out var userId))
        {
            return Unauthorized(new { message = "Vui lòng đăng nhập để tiến hành đặt hàng." });
        }

        if (request.Items == null || !request.Items.Any())
        {
            return BadRequest(new { message = "Đơn hàng phải có ít nhất 1 sản phẩm." });
        }

        // Generate Order Code e.g. ORD-20261113-1234
        var orderCode = $"ORD-{DateTime.UtcNow:yyyyMMdd}-{Random.Shared.Next(1000, 9999)}";

        // Calculate totals and snapshot pricing
        decimal subtotal = 0;
        var orderItems = new List<OrderItem>();

        foreach (var item in request.Items)
        {
            var book = await _context.Books.FindAsync(item.BookId);
            if (book == null || !book.IsAvailable)
            {
                return BadRequest(new { message = $"Sách ID {item.BookId} không khả dụng hoặc đã hết hàng." });
            }

            if (book.StockQuantity < item.Quantity)
            {
                return BadRequest(new { message = $"Sách '{book.Title}' chỉ còn {book.StockQuantity} cuốn trong kho." });
            }

            // Deduct stock
            book.StockQuantity -= item.Quantity;

            var unitPrice = book.SalePrice ?? book.OriginalPrice;
            var lineTotal = unitPrice * item.Quantity;
            subtotal += lineTotal;

            orderItems.Add(new OrderItem
            {
                BookId = book.Id,
                BookTitle = book.Title,
                UnitPrice = unitPrice,
                Quantity = item.Quantity,
                LineTotal = lineTotal
            });
        }

        decimal shippingFee = subtotal >= 300000 ? 0 : 30000;
        decimal discountAmount = 0;

        // Apply discount if provided
        if (!string.IsNullOrWhiteSpace(request.DiscountCode))
        {
            var discount = await _context.Discounts.FirstOrDefaultAsync(d => d.Code == request.DiscountCode.Trim().ToUpper());
            if (discount != null && discount.IsValid(subtotal))
            {
                discountAmount = subtotal * (discount.DiscountPercent / 100m);
                if (discount.MaxDiscountAmount.HasValue && discountAmount > discount.MaxDiscountAmount.Value)
                {
                    discountAmount = discount.MaxDiscountAmount.Value;
                }
                discount.TimesUsed++;
            }
        }

        // Loyalty points redemption: 1 point = 100 VND
        int pointsUsed = 0;
        if (request.PointsToUse > 0)
        {
            var balance = (await GetLoyaltyAsync(userId)).balance;
            var maxByAmount = (int)Math.Floor((subtotal - discountAmount) / PointValue);
            pointsUsed = Math.Max(0, Math.Min(request.PointsToUse, Math.Min(balance, maxByAmount)));
            discountAmount += pointsUsed * PointValue;
            if (pointsUsed > 0)
            {
                var buyer = await _context.Users.FindAsync(userId);
                if (buyer != null) buyer.PointsUsed += pointsUsed;
            }
        }

        decimal finalAmount = subtotal - discountAmount + shippingFee;

        // Create or reuse shipping address if receiver details provided
        Address? shippingAddress = null;
        if (!string.IsNullOrWhiteSpace(request.ReceiverName) && !string.IsNullOrWhiteSpace(request.StreetAddress))
        {
            shippingAddress = new Address
            {
                UserId = userId,
                ReceiverName = request.ReceiverName.Trim(),
                ReceiverPhone = request.ReceiverPhone?.Trim() ?? string.Empty,
                StreetAddress = request.StreetAddress.Trim(),
                Ward = "Phường Bến Nghé",
                District = "Quận 1",
                City = "TP. Hồ Chí Minh",
                IsDefault = false
            };
            _context.Addresses.Add(shippingAddress);
            await _context.SaveChangesAsync();
        }

        var order = new Order
        {
            OrderCode = orderCode,
            UserId = userId,
            ShippingAddressId = shippingAddress?.Id,
            Status = OrderStatus.Pending,
            TotalAmount = subtotal,
            DiscountAmount = discountAmount,
            ShippingFee = shippingFee,
            FinalAmount = finalAmount,
            Note = request.Note,
            PointsUsed = pointsUsed,
            OrderDate = DateTime.UtcNow,
            Items = orderItems,
            Payment = new Payment
            {
                Method = request.PaymentMethod,
                Amount = finalAmount,
                Status = request.PaymentMethod == PaymentMethod.COD ? PaymentStatus.Pending : PaymentStatus.Completed,
                PaymentDate = DateTime.UtcNow,
                TransactionCode = Guid.NewGuid().ToString("N")[..12].ToUpper()
            }
        };

        _context.Orders.Add(order);
        await _context.SaveChangesAsync();

        return Ok(new
        {
            order.Id,
            order.OrderCode,
            order.FinalAmount,
            order.Status,
            PaymentMethod = order.Payment?.Method.ToString(),
            message = "Đặt hàng thành công!"
        });
    }

    [HttpPut("{id:int}/cancel")]
    [Authorize]
    public async Task<IActionResult> CancelOrder(int id)
    {
        var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (string.IsNullOrEmpty(userIdClaim) || !int.TryParse(userIdClaim, out var userId))
        {
            return Unauthorized();
        }

        var order = await _context.Orders
            .Include(o => o.Items)
            .FirstOrDefaultAsync(o => o.Id == id && o.UserId == userId);

        if (order == null)
        {
            return NotFound(new { message = "Không tìm thấy đơn hàng." });
        }

        if (order.Status != OrderStatus.Pending)
        {
            return BadRequest(new { message = "Chỉ có thể hủy đơn hàng đang ở trạng thái 'Chờ xử lý'." });
        }

        // Return stock
        foreach (var item in order.Items)
        {
            var book = await _context.Books.FindAsync(item.BookId);
            if (book != null)
            {
                book.StockQuantity += item.Quantity;
            }
        }

        order.Status = OrderStatus.Cancelled;
        if (order.PointsUsed > 0)
        {
            var owner = await _context.Users.FindAsync(userId);
            if (owner != null) owner.PointsUsed = Math.Max(0, owner.PointsUsed - order.PointsUsed);
        }
        await _context.SaveChangesAsync();

        return Ok(new { message = "Đã hủy đơn hàng thành công!", status = order.Status.ToString() });
    }

    [HttpGet("my-orders")]
    [Authorize]
    public async Task<IActionResult> GetMyOrders()
    {
        var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (string.IsNullOrEmpty(userIdClaim) || !int.TryParse(userIdClaim, out var userId))
        {
            return Unauthorized();
        }

        var orders = await _context.Orders
            .Include(o => o.Items)
            .Include(o => o.Payment)
            .Where(o => o.UserId == userId)
            .OrderByDescending(o => o.OrderDate)
            .Select(o => new
            {
                o.Id,
                o.OrderCode,
                o.OrderDate,
                o.FinalAmount,
                o.PointsUsed,
                Status = o.Status.ToString(),
                Items = o.Items.Select(i => new
                {
                    i.BookTitle,
                    i.Quantity,
                    i.UnitPrice,
                    i.LineTotal
                }),
                PaymentMethod = o.Payment != null ? o.Payment.Method.ToString() : "COD"
            })
            .ToListAsync();

        return Ok(orders);
    }
}

public class CreateOrderRequest
{
    public List<OrderItemRequest> Items { get; set; } = new();
    public PaymentMethod PaymentMethod { get; set; } = PaymentMethod.COD;
    public string? DiscountCode { get; set; }
    public int PointsToUse { get; set; }
    public string? ReceiverName { get; set; }
    public string? ReceiverPhone { get; set; }
    public string? StreetAddress { get; set; }
    public string? Note { get; set; }
}

public class OrderItemRequest
{
    public int BookId { get; set; }
    public int Quantity { get; set; }
}
