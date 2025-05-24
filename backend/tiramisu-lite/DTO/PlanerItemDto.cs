namespace tiramisu_lite.DTO;

public record PlanerItemDto
{
    public Guid Id { get; init; }
    public string Title { get; init; }
    public DateTime EatTime { get; init; }
    public IEnumerable<MealDto> Meals { get; init; }
    public decimal KcalSummary { get; init; }
    public bool Notify { get; init; }
}