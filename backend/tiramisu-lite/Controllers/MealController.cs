namespace tiramisu_lite.Controllers;

using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using tiramisu_lite.Controllers.Requests;
using tiramisu_lite.DTO;
using tiramisu_lite.Exceptions;
using tiramisu_lite.Repositories;

[Route("api/meals")]
public class MealController(
    IMealRepository mealRepository,
    IMapper mapper)
    : ControllerBase
{
    [HttpGet("{id:guid}")]
    public async Task<ActionResult<MealDto>> GetById(Guid id)
    {
        var meal = await mealRepository.GetByIdAsync(id);
        NotFoundException.ThrowIfNull(meal, ExceptionMessages.MealNotFoundMessage(id));
        var dto = mapper.Map<MealDto>(meal);
        return this.Ok(dto);
    }

    [HttpPut("{id:guid}")]
    public async Task<ActionResult> Update(Guid id, [FromBody] MealRequestData.Props props)
    {
        var meal = await mealRepository.GetByIdAsync(id);
        NotFoundException.ThrowIfNull(meal, ExceptionMessages.MealNotFoundMessage(id));
        meal.UpdateName(props.Name);
        meal.UpdateDescription(props.Description);
        meal.UpdateKcal(props.Kcal);
        mealRepository.UpdateAsync(meal);
        return this.NoContent();
    }
}