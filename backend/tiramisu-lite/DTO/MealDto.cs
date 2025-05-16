namespace tiramisu_lite.DTO;

public record MealDto(
    Guid Id,
    string Name,
    string Description,
    decimal Kcal);