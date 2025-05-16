namespace tiramisu_lite.DTO;

public record ShoppingListDto(
    Guid Id,
    string Name,
    IEnumerable<ShoppingListItemDto> Items,
    DateTime CreatedAt);