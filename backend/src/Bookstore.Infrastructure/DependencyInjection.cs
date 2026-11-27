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
                var npgsqlConnStr = BuildPostgresConnectionString(connStr);
                options.UseNpgsql(npgsqlConnStr);
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

    public static string BuildPostgresConnectionString(string connStr)
    {
        if (connStr.StartsWith("postgres://", StringComparison.OrdinalIgnoreCase) ||
            connStr.StartsWith("postgresql://", StringComparison.OrdinalIgnoreCase))
        {
            var uri = new Uri(connStr);
            var userInfo = uri.UserInfo.Split(':');
            var username = userInfo.Length > 0 ? Uri.UnescapeDataString(userInfo[0]) : "";
            var password = userInfo.Length > 1 ? Uri.UnescapeDataString(userInfo[1]) : "";
            var database = uri.AbsolutePath.TrimStart('/');
            var port = uri.Port > 0 ? uri.Port : 5432;

            return $"Host={uri.Host};Port={port};Database={database};Username={username};Password={password};SSL Mode=Require;Trust Server Certificate=true;";
        }

        if (!connStr.Contains("SSL Mode=", StringComparison.OrdinalIgnoreCase))
        {
            connStr += ";SSL Mode=Require;Trust Server Certificate=true;";
        }

        return connStr;
    }
}
