namespace tiramisu_lite.Model;

public class ShoppingList
{
    public Guid Id { get; private set; }
    public Guid ProfileId { get; private set; }
    public Profile Profile { get; init; } = null!;
    public string Name { get; private set; }
    public DateTime CreatedAt { get; private set; }

    public ShoppingList(Guid id, Guid profileId, string name, DateTime createdAt)
    {
        ArgumentNullException.ThrowIfNull(createdAt, nameof(createdAt));
        this.Id = id;
        this.ProfileId = profileId;
        this.Name = name;
        this.CreatedAt = createdAt;
    }

    public required IEnumerable<ShoppingListItem> ShoppingListItems
    {
        get => this.shoppingListItems;
        init => this.shoppingListItems = value.ToList();
    }

    private List<ShoppingListItem> shoppingListItems;

    public bool Completed => this.ShoppingListItems.All(item => item.Completed);

    public void UpdateName(string name)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(name, nameof(this.Name));
        this.Name = name;
    }
}