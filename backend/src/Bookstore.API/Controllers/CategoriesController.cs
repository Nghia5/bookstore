using Bookstore.Infrastructure.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

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
            .ToListAsync();

        return Ok(categories);
    }
}
