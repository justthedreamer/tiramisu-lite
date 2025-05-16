namespace tiramisu_lite.Repositories;

using tiramisu_lite.Database;
using tiramisu_lite.Model;

public class MealRepository(AppDbContext dbContext)
    : Repository<Meal, Guid>(dbContext), IMealRepository;