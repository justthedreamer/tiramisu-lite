namespace tiramisu_lite.DTO;

public record ProfileDto
{
    public Guid Id { get; init; }
    public string Name { get; init; }
    public string AvatarBase64 { get; init; }
}