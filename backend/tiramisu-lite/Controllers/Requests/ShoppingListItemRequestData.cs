namespace tiramisu_lite.Controllers.Requests;

public class ShoppingListItemRequestData
{
    public record Props(string Name, bool Completed);
}