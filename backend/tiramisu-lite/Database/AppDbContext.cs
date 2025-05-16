namespace tiramisu_lite.Database;

using Microsoft.EntityFrameworkCore;
using tiramisu_lite.Model;

public sealed class AppDbContext(DbContextOptions<AppDbContext> dbContextOptions)
    : DbContext(dbContextOptions)
{
    public DbSet<Profile> Profiles { get; set; }
    public DbSet<Meal> Meals { get; set; }
    public DbSet<Planer> Planers { get; set; }
    public DbSet<PlanerItem> PlanerItems { get; set; }
    public DbSet<ShoppingList> ShoppingLists { get; set; }
    public DbSet<ShoppingListItem> ShoppingListItems { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(this.GetType().Assembly);
    }
}