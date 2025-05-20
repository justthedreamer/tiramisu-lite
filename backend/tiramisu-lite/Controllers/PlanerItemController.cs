namespace tiramisu_lite.Controllers;

using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using tiramisu_lite.Controllers.Requests;
using tiramisu_lite.DTO;
using tiramisu_lite.Exceptions;
using tiramisu_lite.Model;
using tiramisu_lite.Repositories;

[Route("api/profiles/{profileName}/planer/{planerId:guid}/items")]
public abstract class PlanerItemController(
    IPlanerRepository planerRepository,
    IPlanerItemRepository planerItemRepository,
    IMapper mapper)
    : ControllerBase
{
    [HttpGet]
    public async Task<ActionResult<IEnumerable<PlanerItemDto>>> GetAll(Guid planerId)
    {
        var planer = await planerRepository.GetByIdAsync(planerId);
        NotFoundException.ThrowIfNull(planer, ExceptionMessages.PlanerNotFoundMessage(planerId));
        var dto = planer.Items.Select(mapper.Map<PlanerItemDto>);
        return this.Ok(dto);
    }

    [HttpGet("{id:guid}")]
    public async Task<ActionResult<PlanerItemDto>> GetById(Guid id)
    {
        var item = await planerItemRepository.GetByIdAsync(id);
        NotFoundException.ThrowIfNull(item, ExceptionMessages.PlanerItemNotFoundMessage(id));
        var dto = mapper.Map<PlanerItem, PlanerItemDto>(item);
        return this.Ok(dto);
    }

    [HttpPost]
    public async Task<ActionResult> Create(
        Guid planerId,
        [FromBody] PlanerItemRequestData.CreateRequest createRequest)
    {
        var planer = await planerRepository.GetByIdAsync(planerId);
        NotFoundException.ThrowIfNull(planer, ExceptionMessages.PlanerNotFoundMessage(planerId));
        var item = this.CreatePlanerItem(planerId, createRequest.Props, createRequest.Meals);
        planerItemRepository.AddAsync(item);
        return this.Created();
    }

    [HttpPut("{id:guid}")]
    public async Task<ActionResult> Update(
        Guid id,
        [FromBody] PlanerItemRequestData.Props props)
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
    public async Task<ActionResult> Delete()
    {
        var item = await planerItemRepository.GetByIdAsync(Guid.NewGuid());
        NotFoundException.ThrowIfNull(item, ExceptionMessages.PlanerItemNotFoundMessage(item.Id));
        planerItemRepository.RemoveAsync(item);
        return this.NoContent();
    }

    private PlanerItem CreatePlanerItem(
        Guid planerId,
        PlanerItemRequestData.Props props,
        IEnumerable<MealRequestData.Props> meals)
    {
        var planerItemId = Guid.NewGuid();
        var planerItem = new PlanerItem(planerItemId, planerId, props.Title, props.EatDate, props.Notify)
        {
            Meals = meals.Select(m => new Meal(Guid.NewGuid(), planerItemId, m.Name, m.Description, m.Kcal)),
        };
        return planerItem;
    }
}