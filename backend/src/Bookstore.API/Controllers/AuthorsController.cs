using Bookstore.Infrastructure.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Bookstore.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class AuthorsController : ControllerBase
{
    private readonly BookstoreDbContext _context;

    public AuthorsController(BookstoreDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<IActionResult> GetAuthors([FromQuery] string? search)
    {
        var query = _context.Authors
            .Include(a => a.BookAuthors)
            .AsNoTracking();

        if (!string.IsNullOrWhiteSpace(search))
        {
            var s = search.Trim();
            if (_context.Database.IsSqlServer())
            {
                query = query.Where(a => 
                    EF.Functions.Like(EF.Functions.Collate(a.Name, "SQL_Latin1_General_CP1_CI_AI"), $"%{s}%")
                    || (a.Nationality != null && EF.Functions.Like(EF.Functions.Collate(a.Nationality, "SQL_Latin1_General_CP1_CI_AI"), $"%{s}%")));
            }
            else
            {
                query = query.Where(a => 
                    EF.Functions.Like(a.Name, $"%{s}%")
                    || (a.Nationality != null && EF.Functions.Like(a.Nationality, $"%{s}%")));
            }
        }

        var authors = await query
            .OrderByDescending(a => a.BookAuthors.Count)
            .Select(a => new
            {
                a.Id,
                a.Name,
                a.Nationality,
                a.Biography,
                a.AvatarUrl,
                BookCount = a.BookAuthors.Count
            })
            .ToListAsync();

        return Ok(authors);
    }

    [HttpGet("{id:int}")]
    public async Task<IActionResult> GetAuthor(int id)
    {
        var author = await _context.Authors
            .Include(a => a.BookAuthors)
            .AsNoTracking()
            .FirstOrDefaultAsync(a => a.Id == id);

        if (author == null)
        {
            return NotFound(new { message = "Không tìm thấy tác giả." });
        }

        return Ok(new
        {
            author.Id,
            author.Name,
            author.Nationality,
            author.Biography,
            author.AvatarUrl,
            BookCount = author.BookAuthors.Count
        });
    }

    [HttpGet("{id:int}/books")]
    public async Task<IActionResult> GetAuthorBooks(int id)
    {
        var author = await _context.Authors.FindAsync(id);
        if (author == null)
        {
            return NotFound(new { message = "Không tìm thấy tác giả." });
        }

        var books = await _context.Books
            .Include(b => b.Category)
            .Include(b => b.BookAuthors).ThenInclude(ba => ba.Author)
            .Where(b => b.IsAvailable && b.BookAuthors.Any(ba => ba.AuthorId == id))
            .OrderByDescending(b => b.Id)
            .Select(b => new
            {
                b.Id,
                b.ISBN,
                b.Title,
                b.OriginalPrice,
                b.SalePrice,
                b.StockQuantity,
                b.PublishYear,
                b.CoverImageUrl,
                b.IsAvailable,
                Category = b.Category != null ? new { b.Category.Id, b.Category.Name, b.Category.Slug } : null,
                Authors = b.BookAuthors.Select(ba => new { ba.Author.Id, ba.Author.Name })
            })
            .ToListAsync();

        return Ok(new
        {
            author = new
            {
                author.Id,
                author.Name,
                author.Nationality,
                author.Biography,
                author.AvatarUrl,
                BookCount = books.Count
            },
            books
        });
    }
}
