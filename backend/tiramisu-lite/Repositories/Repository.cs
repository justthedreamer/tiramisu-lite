namespace tiramisu_lite.Repositories;

using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;
using tiramisu_lite.Database;

public abstract class Repository<TEntity, TKey>(AppDbContext dbContext)
    : IRepository<TEntity, TKey> where TEntity : class
{
    protected DbSet<TEntity> dbSet => dbContext.Set<TEntity>();

    public async Task AddAsync(TEntity entity)
    {
        this.dbSet.AddAsync(entity);
        await dbContext.SaveChangesAsync();
    }

    public async Task UpdateAsync(TEntity entity)
    {
        this.dbSet.Update(entity);
        await dbContext.SaveChangesAsync();
    }

    public async Task RemoveAsync(TEntity entity)
    {
        this.dbSet.Remove(entity);
        await dbContext.SaveChangesAsync();
    }

    public async Task<IEnumerable<TEntity>> GetAllAsync(Expression<Func<TEntity, bool>>? predicate = null)
    {
        var query = this.dbSet.AsQueryable();

        if (predicate is not null)
        {
            query.Where(predicate);
        }

        return await query.ToListAsync();
    }

    public async Task<TEntity?> GetByIdAsync(TKey id)
    {
        return await this.dbSet.FindAsync(id);
    }
}