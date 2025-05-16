namespace tiramisu_lite.Mapping;

using System.Reflection;

public static class Extensions
{
    public static IServiceCollection AppDtoMapping(this IServiceCollection services)
    {
        var assembly = Assembly.GetAssembly(typeof(PlanerProfile));
        services.AddAutoMapper(cfg => { cfg.AddMaps(assembly); });
        return services;
    }
}