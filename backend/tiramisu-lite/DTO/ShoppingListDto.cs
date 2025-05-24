namespace tiramisu_lite.DTO;

public record ShoppingListDto
{
    public Guid Id { get; init; }
    public string Name { get; init; }
    public IEnumerable<ShoppingListItemDto> Items { get; init; }
    public DateTime CreatedAt { get; init; }
}