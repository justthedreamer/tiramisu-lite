namespace tiramisu_lite.Repositories;

using System.Linq.Expressions;

public interface IRepository<TEntity, in TKey> where TEntity : class
{
    public Task AddAsync(TEntity entity);

    public Task UpdateAsync(TEntity entity);

    public Task RemoveAsync(TEntity entity);

    public Task<IEnumerable<TEntity>> GetAllAsync(Expression<Func<TEntity,bool>>? predicate = null);

    public Task<TEntity?> GetByIdAsync(TKey id);
}