namespace tiramisu_lite.Repositories;

using tiramisu_lite.Database;
using tiramisu_lite.Model;

public class PlanerItemRepository(AppDbContext dbContext)
    : Repository<PlanerItem, Guid>(dbContext), IPlanerItemRepository;