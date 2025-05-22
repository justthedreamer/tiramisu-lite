namespace tiramisu_lite.Controllers.Requests;

public sealed record PlanerItemProps(string Title, DateTime EatDate, bool Notify);

public sealed record PlanerItemCreateData(PlanerItemProps Props, IEnumerable<MealProps> Meals);