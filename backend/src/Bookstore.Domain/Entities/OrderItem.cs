namespace Bookstore.Domain.Entities;

public class OrderItem
{
    public int Id { get; set; }
    public int OrderId { get; set; }
    public int BookId { get; set; }
    public string BookTitle { get; set; } = string.Empty; // snapshot
    public decimal UnitPrice { get; set; } // snapshot
    public int Quantity { get; set; }
    public decimal LineTotal { get; set; }

    public Order Order { get; set; } = null!;
    public Book Book { get; set; } = null!;
}
