namespace tiramisu_lite.Repositories;

using tiramisu_lite.Database;
using tiramisu_lite.Model;

public class ShoppingListItemRepository(AppDbContext dbContext)
    : Repository<ShoppingListItem, Guid>(dbContext), IShoppingListItemRepository;