namespace Bookstore.Domain.Entities;

public class Review
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public int BookId { get; set; }
    public int Rating { get; set; } // 1-5
    public string? Comment { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public string? AdminReply { get; set; }
    public DateTime? AdminReplyAt { get; set; }

    public User User { get; set; } = null!;
    public Book Book { get; set; } = null!;
}
