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
        var connStr = configuration.GetConnectionString("DefaultConnection");
        var isProduction = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") == "Production";

        // If no connection string is provided, or if in Production with a localhost connection string (e.g. Render cloud), fallback to SQLite
        bool shouldUseSqlite = string.IsNullOrWhiteSpace(connStr) ||
                               connStr.Contains(".db", StringComparison.OrdinalIgnoreCase) ||
                               (isProduction && connStr.Contains("localhost", StringComparison.OrdinalIgnoreCase));

        services.AddDbContext<BookstoreDbContext>(options =>
        {
            if (shouldUseSqlite)
            {
                options.UseSqlite("Data Source=bookstore.db");
            }
            else
            {
                options.UseSqlServer(connStr, sqlOptions => sqlOptions.MigrationsAssembly(typeof(BookstoreDbContext).Assembly.FullName));
            }
        });

        // Register repositories
        services.AddScoped(typeof(IGenericRepository<>), typeof(GenericRepository<>));
        services.AddScoped<IUnitOfWork, UnitOfWork>();

        return services;
    }
}
