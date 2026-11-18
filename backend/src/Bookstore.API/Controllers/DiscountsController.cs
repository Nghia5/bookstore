using Bookstore.Infrastructure.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Bookstore.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class DiscountsController : ControllerBase
{
    private readonly BookstoreDbContext _context;

    public DiscountsController(BookstoreDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<IActionResult> GetActiveDiscounts()
    {
        var now = DateTime.UtcNow;
        var discounts = await _context.Discounts
            .Where(d => d.IsActive && d.StartDate <= now && d.EndDate >= now && (d.UsageLimit == null || d.TimesUsed < d.UsageLimit))
            .OrderBy(d => d.MinOrderAmount)
            .Select(d => new
            {
                d.Id,
                d.Code,
                d.DiscountPercent,
                d.MaxDiscountAmount,
                d.MinOrderAmount,
                d.StartDate,
                d.EndDate,
                d.UsageLimit,
                d.TimesUsed,
                d.IsActive
            })
            .ToListAsync();

        return Ok(discounts);
    }

    [HttpPost("validate")]
    public async Task<IActionResult> ValidateDiscount([FromBody] ValidateDiscountRequest request)
    {
        if (string.IsNullOrWhiteSpace(request.Code))
        {
            return BadRequest(new { message = "Vui lòng nhập mã giảm giá." });
        }

        var code = request.Code.Trim().ToUpper();
        var discount = await _context.Discounts.FirstOrDefaultAsync(d => d.Code == code);

        if (discount == null)
        {
            return NotFound(new { isValid = false, message = "Mã giảm giá không tồn tại." });
        }

        var now = DateTime.UtcNow;
        if (!discount.IsActive || now < discount.StartDate || now > discount.EndDate)
        {
            return BadRequest(new { isValid = false, message = "Mã giảm giá đã hết hạn hoặc chưa có hiệu lực." });
        }

        if (discount.UsageLimit.HasValue && discount.TimesUsed >= discount.UsageLimit.Value)
        {
            return BadRequest(new { isValid = false, message = "Mã giảm giá đã hết lượt sử dụng." });
        }

        if (discount.MinOrderAmount.HasValue && request.OrderAmount < discount.MinOrderAmount.Value)
        {
            return BadRequest(new
            {
                isValid = false,
                message = $"Đơn hàng cần đạt tối thiểu {discount.MinOrderAmount.Value:N0} đ để áp dụng mã này."
            });
        }

        decimal discountAmount = request.OrderAmount * (discount.DiscountPercent / 100m);
        if (discount.MaxDiscountAmount.HasValue && discountAmount > discount.MaxDiscountAmount.Value)
        {
            discountAmount = discount.MaxDiscountAmount.Value;
        }

        return Ok(new
        {
            isValid = true,
            code = discount.Code,
            discountPercent = discount.DiscountPercent,
            discountAmount,
            maxDiscountAmount = discount.MaxDiscountAmount,
            minOrderAmount = discount.MinOrderAmount,
            message = $"Áp dụng mã {discount.Code} thành công! Giảm {discountAmount:N0} đ."
        });
    }
}

public class ValidateDiscountRequest
{
    public string Code { get; set; } = string.Empty;
    public decimal OrderAmount { get; set; }
}
