namespace tiramisu_lite.Controllers.Requests;

public class ShoppingListRequestData
{
    public record Props(string Name);

    public record Request(Props Props, IEnumerable<ShoppingListItemRequestData.Props> Items);
}