namespace tiramisu_lite.Repositories;

using tiramisu_lite.Model;

public interface IPlanerRepository : IRepository<Planer, Guid>
{
    Task<Planer?> GetByProfileName(string profileName);
}