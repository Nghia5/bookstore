namespace Bookstore.Domain.Entities;

public class Discount
{
    public int Id { get; set; }
    public string Code { get; set; } = string.Empty;
    public decimal DiscountPercent { get; set; }
    public decimal? MaxDiscountAmount { get; set; }
    public decimal? MinOrderAmount { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public int? UsageLimit { get; set; }
    public int TimesUsed { get; set; }
    public bool IsActive { get; set; } = true;

    public bool IsValid(decimal orderAmount)
    {
        var now = DateTime.UtcNow;
        return IsActive
            && now >= StartDate && now <= EndDate
            && (MinOrderAmount == null || orderAmount >= MinOrderAmount)
            && (UsageLimit == null || TimesUsed < UsageLimit);
    }
}
