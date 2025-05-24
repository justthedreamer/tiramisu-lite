namespace tiramisu_lite.DTO;

public class PlanerDto
{
    public Guid Id { get; init; }
    public IEnumerable<PlanerItemDto> Items { get; init; }
}