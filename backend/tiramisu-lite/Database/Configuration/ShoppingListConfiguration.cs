namespace tiramisu_lite.Database.Configuration;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using tiramisu_lite.Model;

public class ShoppingListConfiguration : IEntityTypeConfiguration<ShoppingList>
{
    public void Configure(EntityTypeBuilder<ShoppingList> builder)
    {
        builder.HasKey(sl => sl.Id);

        builder.HasMany(sl => sl.ShoppingListItems)
            .WithOne(sl => sl.ShoppingList)
            .HasForeignKey(sl => sl.ShoppingListId);
    }
}