using Bookstore.Domain.Enums;

namespace Bookstore.Domain.Entities;

public class Order
{
    public int Id { get; set; }
    public string OrderCode { get; set; } = string.Empty;
    public int UserId { get; set; }
    public int? ShippingAddressId { get; set; }
    public OrderStatus Status { get; set; } = OrderStatus.Pending;
    public decimal TotalAmount { get; set; }
    public decimal DiscountAmount { get; set; }
    public decimal ShippingFee { get; set; }
    public decimal FinalAmount { get; set; }
    public string? Note { get; set; }
    public DateTime OrderDate { get; set; } = DateTime.UtcNow;

    public User User { get; set; } = null!;
    public Address? ShippingAddress { get; set; }
    public ICollection<OrderItem> Items { get; set; } = new List<OrderItem>();
    public Payment? Payment { get; set; }
}
