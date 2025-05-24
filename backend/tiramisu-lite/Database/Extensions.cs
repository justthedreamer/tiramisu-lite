namespace tiramisu_lite.Database;

using Microsoft.EntityFrameworkCore;
using tiramisu_lite.Repositories;

public static class Extensions
{
    private const string ConfigurationSectionName = "postgres";

    public static IServiceCollection AddPostgres(this IServiceCollection services, IConfiguration configuration)
    {
        var options = GetPostgresOptions(configuration);

        services
            .AddDbContext<AppDbContext>(builder => builder.UseNpgsql(options.ConnectionString))
            .AddScoped<IMealRepository, MealRepository>()
            .AddScoped<IPlanerItemRepository, PlanerItemRepository>()
            .AddScoped<IPlanerRepository, PlanerRepository>()
            .AddScoped<IProfileRepository, ProfileRepository>()
            .AddScoped<IShoppingListItemRepository, ShoppingListItemRepository>()
            .AddScoped<IShoppingListRepository, ShoppingListRepository>();

        AppContext.SetSwitch("Npgsql.EnableLegacyTimestampBehavior", true);
        
        services.AddHostedService<MigrationService>();

        return services;
    }

    private static PostgresOptions GetPostgresOptions(IConfiguration configuration)
    {
        var section = configuration.GetSection(ConfigurationSectionName);
        var options = new PostgresOptions();
        section.Bind(options);
        return options;
    }
}