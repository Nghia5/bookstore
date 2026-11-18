using System.Security.Claims;
using Bookstore.Domain.Entities;
using Bookstore.Infrastructure.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Bookstore.API.Controllers;

[ApiController]
[Route("api/books/{bookId:int}/[controller]")]
public class ReviewsController : ControllerBase
{
    private readonly BookstoreDbContext _context;

    public ReviewsController(BookstoreDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<IActionResult> GetBookReviews(int bookId)
    {
        var reviews = await _context.Reviews
            .Include(r => r.User)
            .Where(r => r.BookId == bookId)
            .OrderByDescending(r => r.CreatedAt)
            .Select(r => new
            {
                r.Id,
                r.UserId,
                UserName = r.User.FullName,
                r.Rating,
                r.Comment,
                r.CreatedAt
            })
            .ToListAsync();

        var totalReviews = reviews.Count;
        var averageRating = totalReviews > 0 ? Math.Round(reviews.Average(r => r.Rating), 1) : 5.0;

        var starDistribution = new int[5]; // 1 star to 5 star
        foreach (var r in reviews)
        {
            if (r.Rating >= 1 && r.Rating <= 5)
            {
                starDistribution[r.Rating - 1]++;
            }
        }

        return Ok(new
        {
            bookId,
            averageRating,
            totalReviews,
            starCounts = new
            {
                star1 = starDistribution[0],
                star2 = starDistribution[1],
                star3 = starDistribution[2],
                star4 = starDistribution[3],
                star5 = starDistribution[4]
            },
            items = reviews
        });
    }

    [HttpPost]
    [Authorize]
    public async Task<IActionResult> CreateOrUpdateReview(int bookId, [FromBody] CreateReviewRequest request)
    {
        var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (string.IsNullOrEmpty(userIdClaim) || !int.TryParse(userIdClaim, out var userId))
        {
            return Unauthorized(new { message = "Vui lòng đăng nhập để đánh giá tác phẩm." });
        }

        if (request.Rating < 1 || request.Rating > 5)
        {
            return BadRequest(new { message = "Số sao đánh giá phải từ 1 đến 5 sao." });
        }

        var book = await _context.Books.FindAsync(bookId);
        if (book == null)
        {
            return NotFound(new { message = "Không tìm thấy tựa sách này." });
        }

        var existingReview = await _context.Reviews
            .FirstOrDefaultAsync(r => r.BookId == bookId && r.UserId == userId);

        if (existingReview != null)
        {
            existingReview.Rating = request.Rating;
            existingReview.Comment = request.Comment?.Trim();
            existingReview.CreatedAt = DateTime.UtcNow;
            await _context.SaveChangesAsync();

            return Ok(new
            {
                message = "Cập nhật đánh giá thành công!",
                review = new
                {
                    existingReview.Id,
                    existingReview.UserId,
                    existingReview.Rating,
                    existingReview.Comment,
                    existingReview.CreatedAt
                }
            });
        }

        var review = new Review
        {
            BookId = bookId,
            UserId = userId,
            Rating = request.Rating,
            Comment = request.Comment?.Trim(),
            CreatedAt = DateTime.UtcNow
        };

        _context.Reviews.Add(review);
        await _context.SaveChangesAsync();

        var user = await _context.Users.FindAsync(userId);

        return Ok(new
        {
            message = "Gửi đánh giá thành công! Cảm ơn cảm nhận của bạn.",
            review = new
            {
                review.Id,
                review.UserId,
                UserName = user?.FullName ?? "Độc giả",
                review.Rating,
                review.Comment,
                review.CreatedAt
            }
        });
    }
}

public class CreateReviewRequest
{
    public int Rating { get; set; }
    public string? Comment { get; set; }
}
