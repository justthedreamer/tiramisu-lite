namespace tiramisu_lite.DTO;

public record ShoppingListItemDto(
    Guid Id,
    string Name,
    bool Completed);