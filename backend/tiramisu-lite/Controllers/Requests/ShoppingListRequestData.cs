namespace tiramisu_lite.Controllers.Requests;

public sealed record ShoppingListProps(string Name);

public sealed record ShoppingListCreateData(string Name, IEnumerable<ShoppingListItemProps> Items);