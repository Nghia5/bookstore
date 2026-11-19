using Microsoft.EntityFrameworkCore;

namespace Bookstore.Infrastructure.Data;

public static class DiscountCleanup
{
    /// <summary>Deletes vouchers that expired or ran out of usages.</summary>
    public static async Task PurgeAsync(BookstoreDbContext context)
    {
        var now = DateTime.UtcNow;
        var dead = await context.Discounts
            .Where(d => d.EndDate < now || (d.UsageLimit != null && d.TimesUsed >= d.UsageLimit))
            .ToListAsync();
        if (dead.Count == 0) return;
        context.Discounts.RemoveRange(dead);
        await context.SaveChangesAsync();
    }
}