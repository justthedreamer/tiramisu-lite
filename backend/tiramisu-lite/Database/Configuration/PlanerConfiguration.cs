namespace tiramisu_lite.Database.Configuration;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using tiramisu_lite.Model;

public class PlanerConfiguration : IEntityTypeConfiguration<Planer>
{
    public void Configure(EntityTypeBuilder<Planer> builder)
    {
        builder.HasKey(p => p.Id);

        builder.HasMany(p => p.Items)
            .WithOne(p => p.Planer)
            .HasForeignKey(p => p.PlanerId);
    }
}