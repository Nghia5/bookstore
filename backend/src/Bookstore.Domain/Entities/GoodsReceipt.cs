namespace Bookstore.Domain.Entities;

public class GoodsReceipt
{
    public int Id { get; set; }
    public string ReceiptCode { get; set; } = string.Empty;
    public string SupplierName { get; set; } = string.Empty;
    public DateTime CreatedDate { get; set; } = DateTime.UtcNow;
    public string CreatedBy { get; set; } = string.Empty;
    public decimal TotalAmount { get; set; }
    public string? Note { get; set; }

    public ICollection<GoodsReceiptItem> Items { get; set; } = new List<GoodsReceiptItem>();
}
