namespace tiramisu_lite.Repositories;

using tiramisu_lite.Model;

public interface IProfileRepository : IRepository<Profile, Guid>
{
    Task<Profile?> GetByNameAsync(string name);
    Task EnsureProfileNotExistsAsync(string name);
}