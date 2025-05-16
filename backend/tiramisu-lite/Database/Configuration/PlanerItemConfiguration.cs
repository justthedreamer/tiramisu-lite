namespace tiramisu_lite.Database.Configuration;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using tiramisu_lite.Model;

public class PlanerItemConfiguration : IEntityTypeConfiguration<PlanerItem>
{
    public void Configure(EntityTypeBuilder<PlanerItem> builder)
    {
        builder.HasKey(pi => pi.Id);

        builder.HasMany(pi => pi.Meals)
            .WithOne(m => m.PlanerItem)
            .HasForeignKey(m => m.PlanerItemId);
    }
}