namespace tiramisu_lite.Controllers.Requests;

public static class MealRequestData
{
    public record Props(string Name, string Description, decimal Kcal);
}