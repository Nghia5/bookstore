using Bookstore.Domain.Entities;
using Bookstore.Infrastructure.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Bookstore.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class BooksController : ControllerBase
{
    private readonly BookstoreDbContext _context;

    public BooksController(BookstoreDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<IActionResult> GetBooks(
        [FromQuery] string? search,
        [FromQuery] int? categoryId,
        [FromQuery] int? authorId,
        [FromQuery] decimal? minPrice,
        [FromQuery] decimal? maxPrice,
        [FromQuery] string? sortBy,
        [FromQuery] int page = 1,
        [FromQuery] int pageSize = 12)
    {
        var query = _context.Books
            .Include(b => b.Category)
            .Include(b => b.Publisher)
            .Include(b => b.BookAuthors).ThenInclude(ba => ba.Author)
            .Include(b => b.Reviews)
            .Where(b => b.IsAvailable)
            .AsNoTracking();

        if (!string.IsNullOrWhiteSpace(search))
        {
            var s = search.Trim();
            query = query.Where(b => 
                EF.Functions.Like(EF.Functions.Collate(b.Title, "SQL_Latin1_General_CP1_CI_AI"), $"%{s}%")
                || b.ISBN.Contains(s)
                || b.BookAuthors.Any(ba => EF.Functions.Like(EF.Functions.Collate(ba.Author.Name, "SQL_Latin1_General_CP1_CI_AI"), $"%{s}%")));
        }

        if (categoryId.HasValue)
        {
            query = query.Where(b => b.CategoryId == categoryId.Value);
        }

        if (authorId.HasValue && authorId.Value > 0)
        {
            query = query.Where(b => b.BookAuthors.Any(ba => ba.AuthorId == authorId.Value));
        }

        if (minPrice.HasValue)
        {
            query = query.Where(b => (b.SalePrice ?? b.OriginalPrice) >= minPrice.Value);
        }

        if (maxPrice.HasValue)
        {
            query = query.Where(b => (b.SalePrice ?? b.OriginalPrice) <= maxPrice.Value);
        }

        var totalCount = await query.CountAsync();

        query = sortBy switch
        {
            "price_asc" => query.OrderBy(b => b.SalePrice ?? b.OriginalPrice),
            "price_desc" => query.OrderByDescending(b => b.SalePrice ?? b.OriginalPrice),
            "name_asc" => query.OrderBy(b => b.Title),
            _ => query.OrderByDescending(b => b.CreatedAt)
        };

        var items = await query
            .Skip((page - 1) * pageSize)
            .Take(pageSize)
            .Select(b => new
            {
                b.Id,
                b.ISBN,
                b.Title,
                b.Description,
                b.OriginalPrice,
                b.SalePrice,
                b.StockQuantity,
                b.PageCount,
                b.PublishYear,
                b.Language,
                b.CoverImageUrl,
                b.IsAvailable,
                Category = b.Category != null ? new { b.Category.Id, b.Category.Name, b.Category.Slug } : null,
                Publisher = b.Publisher != null ? new { b.Publisher.Id, b.Publisher.Name } : null,
                Authors = b.BookAuthors.Select(ba => new { ba.Author.Id, ba.Author.Name }),
                AverageRating = b.Reviews.Any() ? Math.Round(b.Reviews.Average(r => r.Rating), 1) : 5.0,
                ReviewCount = b.Reviews.Count
            })
            .ToListAsync();

        return Ok(new
        {
            items,
            totalCount,
            page,
            pageSize,
            totalPages = (int)Math.Ceiling(totalCount / (double)pageSize)
        });
    }

    [HttpGet("{id:int}")]
    public async Task<IActionResult> GetBookById(int id)
    {
        var book = await _context.Books
            .Include(b => b.Category)
            .Include(b => b.Publisher)
            .Include(b => b.BookAuthors).ThenInclude(ba => ba.Author)
            .Include(b => b.Reviews).ThenInclude(r => r.User)
            .AsNoTracking()
            .FirstOrDefaultAsync(b => b.Id == id);

        if (book == null) return NotFound(new { message = "Không tìm thấy cuốn sách này." });

        return Ok(new
        {
            book.Id,
            book.ISBN,
            book.Title,
            book.Description,
            book.OriginalPrice,
            book.SalePrice,
            book.StockQuantity,
            book.PageCount,
            book.PublishYear,
            book.Language,
            book.CoverImageUrl,
            book.IsAvailable,
            Category = book.Category != null ? new { book.Category.Id, book.Category.Name, book.Category.Slug } : null,
            Publisher = book.Publisher != null ? new { book.Publisher.Id, book.Publisher.Name } : null,
            Authors = book.BookAuthors.Select(ba => new { ba.Author.Id, ba.Author.Name, ba.Author.Biography }),
            AverageRating = book.Reviews.Any() ? Math.Round(book.Reviews.Average(r => r.Rating), 1) : 5.0,
            Reviews = book.Reviews.Select(r => new
            {
                r.Id,
                r.Rating,
                r.Comment,
                r.CreatedAt,
                UserName = r.User.FullName
            })
        });
    }

    [HttpGet("featured")]
    public async Task<IActionResult> GetFeaturedBooks()
    {
        var books = await _context.Books
            .Include(b => b.Category)
            .Include(b => b.BookAuthors).ThenInclude(ba => ba.Author)
            .Include(b => b.Reviews)
            .Where(b => b.IsAvailable)
            .Take(8)
            .Select(b => new
            {
                b.Id,
                b.Title,
                b.OriginalPrice,
                b.SalePrice,
                b.CoverImageUrl,
                Authors = b.BookAuthors.Select(ba => new { ba.Author.Id, ba.Author.Name }),
                AverageRating = b.Reviews.Any() ? Math.Round(b.Reviews.Average(r => r.Rating), 1) : 5.0,
                ReviewCount = b.Reviews.Count
            })
            .ToListAsync();

        return Ok(books);
    }
}
