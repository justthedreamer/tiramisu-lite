namespace tiramisu_lite.Model;

public class ShoppingListItem
{
    public ShoppingListItem(Guid id, Guid shoppingListId, string name, bool completed)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(name, nameof(name));
        this.Id = id;
        this.ShoppingListId = shoppingListId;
        this.Name = name;
        this.Completed = completed;
    }

    public Guid Id { get; private set; }
    public Guid ShoppingListId { get; set; }
    public ShoppingList ShoppingList { get; set; } = null!;
    public string Name { get; private set; }
    public bool Completed { get; private set; }

    public void UpdateName(string name)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(name, nameof(this.Name));
        this.Name = name;
    }

    public void UpdateCompleted(bool completed)
    {
        this.Completed = completed;
    }
}