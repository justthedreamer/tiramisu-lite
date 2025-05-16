namespace tiramisu_lite.DTO;

public record PlanerItemDto(
    Guid Id,
    string Title,
    DateTime EatTime,
    IEnumerable<MealDto> Meals,
    decimal KcalSummary,
    bool Notify);