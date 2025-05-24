namespace tiramisu_lite.Controllers;

using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using tiramisu_lite.Controllers.Requests;
using tiramisu_lite.DTO;
using tiramisu_lite.Exceptions;
using tiramisu_lite.Model;
using tiramisu_lite.Repositories;

[Route("api/profiles/{profileName}/planer")]
public class PlanerController(
    IPlanerRepository planerRepository,
    IMapper mapper) : ControllerBase
{
    [HttpGet]
    public async Task<ActionResult<PlanerDto>> GetById(string profileName)
    {
        var planer = await planerRepository.GetByProfileName(profileName);
        NotFoundException.ThrowIfNull(planer, ExceptionMessages.ProfileNotFoundMessage(profileName));
        var dto = mapper.Map<Planer,PlanerDto>(planer);
        return this.Ok(dto);
    }
}