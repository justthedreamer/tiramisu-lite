namespace tiramisu_lite.Model;

public class Profile
{
    public Guid Id { get; set; }
    public string Name { get; private set; }
    public string AvatarBase64 { get; private set; }
    public required Planer Planer { get; init; }
    public IEnumerable<ShoppingList> ShoppingLists => this.shoppingLists;
    private List<ShoppingList> shoppingLists;

    public Profile(Guid id, string name, string avatarBase64)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(name, nameof(name));
        ArgumentException.ThrowIfNullOrWhiteSpace(avatarBase64, nameof(avatarBase64));
        this.Id = id;
        this.Name = name;
        this.AvatarBase64 = avatarBase64;
    }

    public void UpdateName(string name)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(name, nameof(name));
        this.Name = name;
    }

    public void UpdateAvatar(string avatar)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(avatar, nameof(avatar));
        this.AvatarBase64 = avatar;
    }
}