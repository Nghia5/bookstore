using System.Reflection;
using FluentValidation;
using Microsoft.Extensions.DependencyInjection;

namespace Bookstore.Application;

public static class DependencyInjection
{
    public static IServiceCollection AddApplication(this IServiceCollection services)
    {
        var assembly = Assembly.GetExecutingAssembly();

        // Register AutoMapper
        services.AddAutoMapper(cfg => cfg.AddMaps(assembly));

        // Register MediatR
        services.AddMediatR(cfg => cfg.RegisterServicesFromAssembly(assembly));

        // Register FluentValidation
        services.AddValidatorsFromAssembly(assembly);

        return services;
    }
}
