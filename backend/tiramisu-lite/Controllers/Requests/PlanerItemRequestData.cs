namespace tiramisu_lite.Controllers.Requests;

public class PlanerItemRequestData
{
    public record Props(string Title, DateTime EatDate, bool Notify);

    public record CreateRequest(Props Props, IEnumerable<MealRequestData.Props> Meals);
}