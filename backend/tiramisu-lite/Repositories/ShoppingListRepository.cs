namespace tiramisu_lite.Repositories;

using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;
using tiramisu_lite.Database;
using tiramisu_lite.Model;

public class ShoppingListRepository(AppDbContext dbContext)
    : Repository<ShoppingList, Guid>(dbContext), IShoppingListRepository
{
    public async Task<IEnumerable<ShoppingList>> GetAllAsync(Expression<Func<ShoppingList, bool>>? predicate = null)
    {
        var query = this.dbSet.AsQueryable();

        if (predicate is not null)
        {
            query.Where(predicate);
        }

        return await query.ToListAsync();
    }
}