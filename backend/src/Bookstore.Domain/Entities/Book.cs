namespace Bookstore.Domain.Entities;

public class Book
{
    public int Id { get; set; }
    public string ISBN { get; set; } = string.Empty;
    public string Title { get; set; } = string.Empty;
    public string? Description { get; set; }
    public decimal OriginalPrice { get; set; }
    public decimal? SalePrice { get; set; }
    public int StockQuantity { get; set; }
    public int? PageCount { get; set; }
    public int? PublishYear { get; set; }
    public string Language { get; set; } = "vi";
    public string? CoverImageUrl { get; set; }
    public bool IsAvailable { get; set; } = true;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    public int? CategoryId { get; set; }
    public int? PublisherId { get; set; }

    public Category? Category { get; set; }
    public Publisher? Publisher { get; set; }
    public ICollection<BookAuthor> BookAuthors { get; set; } = new List<BookAuthor>();
    public ICollection<Review> Reviews { get; set; } = new List<Review>();
    public ICollection<OrderItem> OrderItems { get; set; } = new List<OrderItem>();

    public decimal GetFinalPrice() => SalePrice ?? OriginalPrice;
    public bool IsInStock(int quantity = 1) => IsAvailable && StockQuantity >= quantity;
}
