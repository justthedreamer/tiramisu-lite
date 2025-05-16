namespace tiramisu_lite.Controllers;

using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using tiramisu_lite.DTO;
using tiramisu_lite.Exceptions;
using tiramisu_lite.Model;
using tiramisu_lite.Repositories;
using Profile = tiramisu_lite.Model.Profile;

[Route("api/profiles")]
public class ProfileController(IProfileRepository profileRepository, IMapper mapper)
    : ControllerBase
{
    [HttpGet]
    public async Task<ActionResult<IEnumerable<ProfileDto>>> GetAll()
    {
        var profiles = await profileRepository.GetAllAsync();
        var dto = profiles.Select(mapper.Map<Profile, ProfileDto>);
        return this.Ok(dto);
    }

    [HttpPost]
    public async Task<ActionResult> Create(
        [FromBody] ProfileProps props)
    {
        await profileRepository.EnsureProfileNotExistsAsync(props.Name);
        var profile = new Profile(Guid.NewGuid(), props.Name, props.AvatarBase64)
        {
            Planer = new Planer(Guid.NewGuid()),
        };
        await profileRepository.AddAsync(profile);
        return this.Created();
    }

    [HttpPut("{name}")]
    public async Task<ActionResult> Update(
        string name,
        [FromBody] ProfileProps props)
    {
        var profile = await profileRepository.GetByNameAsync(name);
        NotFoundException.ThrowIfNull(profile, ExceptionMessages.ProfileNotFoundMessage(name));
        profile.UpdateName(props.Name);
        profile.UpdateAvatar(props.AvatarBase64);
        await profileRepository.UpdateAsync(profile);
        return this.NoContent();
    }

    [HttpDelete("{name}")]
    public async Task<ActionResult> Delete(string name)
    {
        var profile = await profileRepository.GetByNameAsync(name);
        NotFoundException.ThrowIfNull(profile, ExceptionMessages.ProfileNotFoundMessage(name));
        await profileRepository.RemoveAsync(profile);
        return this.NoContent();
    }

    public record ProfileProps(string Name, string AvatarBase64);
}