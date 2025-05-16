namespace tiramisu_lite.DTO;

public record PlanerDto(
    Guid Id,
    IEnumerable<PlanerItemDto> PlanerItems);
