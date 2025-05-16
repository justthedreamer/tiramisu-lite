namespace tiramisu_lite.Exceptions;

public static class ExceptionMessages
{
    public static string ProfileNotFoundMessage(string name) => $"Profile with name: {name}, was not found.";
    public static string PlanerNotFoundMessage(Guid id) => $"Planer with ID: {id}, was not found.";
    public static string PlanerItemNotFoundMessage(Guid id) => $"Planer item with ID: {id}, was not found.";
    public static string MealNotFoundMessage(Guid id) => $"Meal with ID: {id}, was not found.";
    public static string ShoppingListNotFoundMessage(Guid id) => $"Shopping list with ID: {id}, was not found.";

    public static string ShoppingListItemNotFoundMessage(Guid id) =>
        $"Shopping list item with ID: {id}, was not found.";
}