namespace tiramisu_lite.Database.Configuration;

using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using tiramisu_lite.Model;

public class ProfileConfiguration : IEntityTypeConfiguration<Profile>
{
    public void Configure(EntityTypeBuilder<Profile> builder)
    {
        builder.HasKey(p => p.Id);

        builder
            .HasIndex(p => p.Name)
            .IsUnique();

        builder
            .HasOne(p => p.Planer)
            .WithOne(p => p.Profile)
            .HasForeignKey<Profile>();

        builder.HasMany(p => p.ShoppingLists)
            .WithOne(s => s.Profile)
            .HasForeignKey(s => s.ProfileId);
    }
}