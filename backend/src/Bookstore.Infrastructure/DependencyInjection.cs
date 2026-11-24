using Bookstore.Domain.Interfaces;
using Bookstore.Infrastructure.Data;
using Bookstore.Infrastructure.Repositories;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Bookstore.Infrastructure;

public static class DependencyInjection
{
    public static IServiceCollection AddInfrastructure(this IServiceCollection services, IConfiguration configuration)
    {
        var connStr = configuration.GetConnectionString("DefaultConnection") ?? "";

        services.AddDbContext<BookstoreDbContext>(options =>
        {
            if (connStr.Contains("Host=", StringComparison.OrdinalIgnoreCase) ||
                connStr.Contains("postgres", StringComparison.OrdinalIgnoreCase) ||
                connStr.Contains("sslmode=", StringComparison.OrdinalIgnoreCase))
            {
                // Managed PostgreSQL (Render managed DB, Supabase, Neon, AWS RDS, etc.)
                options.UseNpgsql(connStr);
            }
            else if (!string.IsNullOrWhiteSpace(connStr) &&
                     !connStr.Contains(".db", StringComparison.OrdinalIgnoreCase) &&
                     (connStr.Contains("Server=", StringComparison.OrdinalIgnoreCase) ||
                      (connStr.Contains("Data Source=", StringComparison.OrdinalIgnoreCase) && connStr.Contains("User", StringComparison.OrdinalIgnoreCase))))
            {
                // SQL Server
                options.UseSqlServer(connStr, sqlOptions => sqlOptions.MigrationsAssembly(typeof(BookstoreDbContext).Assembly.FullName));
            }
            else
            {
                // Fallback: SQLite for local offline development
                options.UseSqlite(connStr.Contains(".db") ? connStr : "Data Source=bookstore.db");
            }
        });

        // Register repositories
        services.AddScoped(typeof(IGenericRepository<>), typeof(GenericRepository<>));
        services.AddScoped<IUnitOfWork, UnitOfWork>();

        return services;
    }
}
