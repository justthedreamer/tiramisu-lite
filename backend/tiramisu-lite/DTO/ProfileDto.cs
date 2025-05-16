namespace tiramisu_lite.DTO;

public record ProfileDto(
    Guid Id,
    string Name,
    string AvatarBase64);