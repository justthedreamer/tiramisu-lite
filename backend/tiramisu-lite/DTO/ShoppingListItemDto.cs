namespace tiramisu_lite.DTO;

public record ShoppingListItemDto
{
    public Guid Id { get; init; }
    public string Name { get; init; }
    public bool Completed { get; init; }
}