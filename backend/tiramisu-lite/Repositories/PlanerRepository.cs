namespace tiramisu_lite.Repositories;

using Microsoft.EntityFrameworkCore;
using tiramisu_lite.Database;
using tiramisu_lite.Model;

public class PlanerRepository(AppDbContext dbContext)
    : Repository<Planer, Guid>(dbContext), IPlanerRepository
{
    public async Task<Planer?> GetByProfileName(string profileName)
    {
        return await this.dbSet
            .Include(p => p.Profile)
            .Include(p => p.Items)
            .ThenInclude(pi => pi.Meals)
            .FirstOrDefaultAsync(p => p.Profile.Name == profileName);
    }
}