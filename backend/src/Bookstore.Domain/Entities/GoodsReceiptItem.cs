namespace Bookstore.Domain.Entities;

public class GoodsReceiptItem
{
    public int Id { get; set; }
    public int ReceiptId { get; set; }
    public int BookId { get; set; }
    public int Quantity { get; set; }
    public decimal CostPrice { get; set; }
    public decimal LineTotal { get; set; }

    public GoodsReceipt Receipt { get; set; } = null!;
    public Book Book { get; set; } = null!;
}
