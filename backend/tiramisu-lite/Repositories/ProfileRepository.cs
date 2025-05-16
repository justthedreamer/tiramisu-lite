namespace tiramisu_lite.Repositories;

using Microsoft.EntityFrameworkCore;
using tiramisu_lite.Database;
using tiramisu_lite.Exceptions;
using tiramisu_lite.Model;

public class ProfileRepository(AppDbContext dbContext)
    : Repository<Profile, Guid>(dbContext), IProfileRepository
{
    public async Task<IEnumerable<Profile>> GetAllAsync()
    {
        return await this.dbSet.Include(p => p.Planer).ToListAsync();
    }

    public async Task<Profile?> GetByNameAsync(string name)
    {
        return await this.dbSet.SingleOrDefaultAsync(p => p.Name == name);
    }

    public async Task EnsureProfileNotExistsAsync(string name)
    {
        if (await this.dbSet.AnyAsync(profile => profile.Name == name))
        {
            throw new AlreadyExistException($"Profile with name: {name} is already exists.");
        }
    }
}