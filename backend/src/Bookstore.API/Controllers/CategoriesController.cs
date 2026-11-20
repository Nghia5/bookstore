using Bookstore.Domain.Entities;
using Bookstore.Infrastructure.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Text.RegularExpressions;

namespace Bookstore.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class CategoriesController : ControllerBase
{
    private readonly BookstoreDbContext _context;

    public CategoriesController(BookstoreDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<IActionResult> GetCategories()
    {
        var categories = await _context.Categories
            .AsNoTracking()
            .Select(c => new
            {
                c.Id,
                c.Name,
                c.Slug,
                c.Description,
                BookCount = c.Books.Count(b => b.IsAvailable)
            })
            .OrderBy(c => c.Name)
            .ToListAsync();

        return Ok(categories);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetCategory(int id)
    {
        var category = await _context.Categories
            .AsNoTracking()
            .Select(c => new
            {
                c.Id,
                c.Name,
                c.Slug,
                c.Description,
                BookCount = c.Books.Count(b => b.IsAvailable)
            })
            .FirstOrDefaultAsync(c => c.Id == id);

        if (category == null)
            return NotFound(new { message = "Không tìm thấy thể loại yêu cầu." });

        return Ok(category);
    }

    [HttpPost]
    public async Task<IActionResult> CreateCategory([FromBody] CreateCategoryRequest request)
    {
        if (string.IsNullOrWhiteSpace(request.Name))
            return BadRequest(new { message = "Tên thể loại không được để trống." });

        var name = request.Name.Trim();
        var slug = !string.IsNullOrWhiteSpace(request.Slug) 
            ? GenerateSlug(request.Slug) 
            : GenerateSlug(name);

        // Check duplicate name or slug
        var exists = await _context.Categories.AnyAsync(c => c.Name.ToLower() == name.ToLower() || c.Slug == slug);
        if (exists)
        {
            slug = $"{slug}-{DateTime.UtcNow.Ticks % 10000}";
        }

        var category = new Category
        {
            Name = name,
            Slug = slug,
            Description = request.Description?.Trim()
        };

        _context.Categories.Add(category);
        await _context.SaveChangesAsync();

        return CreatedAtAction(nameof(GetCategory), new { id = category.Id }, new
        {
            category.Id,
            category.Name,
            category.Slug,
            category.Description,
            BookCount = 0
        });
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> UpdateCategory(int id, [FromBody] UpdateCategoryRequest request)
    {
        var category = await _context.Categories.FindAsync(id);
        if (category == null)
            return NotFound(new { message = "Không tìm thấy thể loại cần sửa." });

        if (string.IsNullOrWhiteSpace(request.Name))
            return BadRequest(new { message = "Tên thể loại không được để trống." });

        category.Name = request.Name.Trim();
        if (!string.IsNullOrWhiteSpace(request.Slug))
        {
            category.Slug = GenerateSlug(request.Slug);
        }
        else if (string.IsNullOrWhiteSpace(category.Slug))
        {
            category.Slug = GenerateSlug(category.Name);
        }

        category.Description = request.Description?.Trim();

        await _context.SaveChangesAsync();

        var bookCount = await _context.Books.CountAsync(b => b.CategoryId == id && b.IsAvailable);

        return Ok(new
        {
            category.Id,
            category.Name,
            category.Slug,
            category.Description,
            BookCount = bookCount,
            message = "Cập nhật thể loại thành công."
        });
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteCategory(int id)
    {
        var category = await _context.Categories
            .Include(c => c.Books)
            .FirstOrDefaultAsync(c => c.Id == id);

        if (category == null)
            return NotFound(new { message = "Không tìm thấy thể loại cần xóa." });

        var bookCount = category.Books.Count;
        if (bookCount > 0)
        {
            return BadRequest(new
            {
                message = $"Không thể xóa thể loại '{category.Name}' vì đang có {bookCount} cuốn sách thuộc thể loại này. Vui lòng chuyển sách sang thể loại khác trước."
            });
        }

        _context.Categories.Remove(category);
        await _context.SaveChangesAsync();

        return Ok(new { message = $"Đã xóa thể loại '{category.Name}' thành công." });
    }

    private static string GenerateSlug(string title)
    {
        if (string.IsNullOrWhiteSpace(title)) return "danh-muc";
        var str = title.ToLowerInvariant().Trim();
        var signs = new string[]
        {
            "aAeEoOuUiIdDyY",
            "áàạảãâấầậẩẫăắằặẳẵ",
            "ÁÀẠẢÃÂẤẦẬẨẪĂẮẰẶẲẴ",
            "éèẹẻẽêếềệểễ",
            "ÉÈẸẺẼÊẾỀỆỂỄ",
            "óòọỏõôốồộổỗơớờợởỡ",
            "ÓÒỌỎÕÔỐỒỘỔỖƠỚỜỢỞỠ",
            "úùụủũưứừựửữ",
            "ÚÙỤỦŨƯỨỪỰỬỮ",
            "íìịỉĩ",
            "ÍÌỊỈĨ",
            "đ",
            "Đ",
            "ýỳỵỷỹ",
            "ÝỲỴỶỸ"
        };
        for (int i = 1; i < signs.Length; i++)
        {
            for (int j = 0; j < signs[i].Length; j++)
                str = str.Replace(signs[i][j], signs[0][i - 1]);
        }
        str = Regex.Replace(str, @"[^a-z0-9\s-]", "");
        str = Regex.Replace(str, @"\s+", "-").Trim('-');
        return string.IsNullOrWhiteSpace(str) ? "danh-muc" : str;
    }
}

public class CreateCategoryRequest
{
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string? Slug { get; set; }
}

public class UpdateCategoryRequest
{
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string? Slug { get; set; }
}
