﻿namespace tiramisu_lite.Controllers;

using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using tiramisu_lite.Controllers.Requests;
using tiramisu_lite.DTO;
using tiramisu_lite.Exceptions;
using tiramisu_lite.Model;
using tiramisu_lite.Repositories;

[Route("api/profiles/{profileName}/planer/items")]
public class PlanerItemController(
    IPlanerRepository planerRepository,
    IPlanerItemRepository planerItemRepository,
    IMapper mapper)
    : ControllerBase
{
    [HttpGet]
    public async Task<ActionResult<IEnumerable<PlanerItemDto>>> GetAll(string profileName)
    {
        var planer = await planerRepository.GetByProfileName(profileName);
        NotFoundException.ThrowIfNull(planer, ExceptionMessages.ProfileNotFoundMessage(profileName));
        var dto = planer.Items.Select(mapper.Map<PlanerItemDto>);
        return this.Ok(dto);
    }

    [HttpGet("{id:guid}")]
    public async Task<ActionResult<PlanerItemDto>> GetById(string profileName, Guid id)
    {
        var item = await planerItemRepository.GetByIdAsync(id);
        NotFoundException.ThrowIfNull(item, ExceptionMessages.PlanerItemNotFoundMessage(id));
        var dto = mapper.Map<PlanerItem, PlanerItemDto>(item);
        return this.Ok(dto);
    }

    [HttpPost]
    public async Task<ActionResult> Create(
        string profileName,
        [FromBody] PlanerItemCreateData createRequest)
    {
        var planer = await planerRepository.GetByProfileName(profileName);
        NotFoundException.ThrowIfNull(planer, ExceptionMessages.ProfileNotFoundMessage(profileName));
        var item = CreatePlanerItem(planer.Id, createRequest.Props, createRequest.Meals);
        await planerItemRepository.AddAsync(item);
        return this.Created();
    }

    [HttpPut("{id:guid}")]
    public async Task<ActionResult> Update(
        string profileName,
        Guid id,
        [FromBody] PlanerItemProps props)
    {
        var item = await planerItemRepository.GetByIdAsync(id);
        NotFoundException.ThrowIfNull(item, ExceptionMessages.PlanerItemNotFoundMessage(id));
        item.UpdateTitle(props.Title);
        item.UpdateEatTime(props.EatDate);
        item.UpdateNotify(props.Notify);
        await planerItemRepository.UpdateAsync(item);
        return this.NoContent();
    }

    [HttpDelete("{id:guid}")]
    public async Task<ActionResult> Delete(string profileName, Guid id)
    {
        var item = await planerItemRepository.GetByIdAsync(id);
        NotFoundException.ThrowIfNull(item, ExceptionMessages.PlanerItemNotFoundMessage(item.Id));
        await planerItemRepository.RemoveAsync(item);
        return this.NoContent();
    }

    private static PlanerItem CreatePlanerItem(
        Guid planerId,
        PlanerItemProps props,
        IEnumerable<MealProps> meals)
    {
        var planerItemId = Guid.NewGuid();
        var planerItem = new PlanerItem(planerItemId, planerId, props.Title, props.EatDate, props.Notify)
        {
            Meals = meals.Select(m => new Meal(Guid.NewGuid(), planerItemId, m.Name, m.Description, m.Kcal)),
        };
        return planerItem;
    }
}