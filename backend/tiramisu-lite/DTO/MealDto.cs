namespace tiramisu_lite.DTO;

public record MealDto
{
    public Guid Id { get; init; }
    public string Name { get; init; }
    public string Description { get; init; }
    public decimal Kcal { get; init; }
}