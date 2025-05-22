namespace tiramisu_lite.Controllers;

using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using tiramisu_lite.Controllers.Requests;
using tiramisu_lite.DTO;
using tiramisu_lite.Exceptions;
using tiramisu_lite.Model;
using tiramisu_lite.Repositories;

[Route("api/shopping-lists/{shoppingListId:guid}/items")]
public class ShoppingListItemController(
    IShoppingListItemRepository shoppingListItemRepository,
    IMapper mapper) : ControllerBase
{
    [HttpGet("{id:guid}")]
    public async Task<ActionResult<ShoppingListItemDto>> GetById(Guid id)
    {
        var item = await shoppingListItemRepository.GetByIdAsync(id);
        NotFoundException.ThrowIfNull(item, ExceptionMessages.ShoppingListItemNotFoundMessage(id));
        var dto = mapper.Map<ShoppingListItem, ShoppingListItemDto>(item);
        return this.Ok(dto);
    }

    [HttpPost]
    public async Task<ActionResult> Create(
        Guid shoppingListId,
        [FromBody] ShoppingListItemProps props)
    {
        var item = new ShoppingListItem(Guid.NewGuid(), shoppingListId, props.Name, props.Completed);
        shoppingListItemRepository.AddAsync(item);
        return this.CreatedAtAction(nameof(GetById), new { id = item.Id }, item);
    }

    [HttpPut("{id:guid}")]
    public async Task<ActionResult> Update(
        Guid id,
        [FromBody] ShoppingListItemProps props)
    {
        var item = await shoppingListItemRepository.GetByIdAsync(id);
        NotFoundException.ThrowIfNull(item, ExceptionMessages.ShoppingListItemNotFoundMessage(id));
        item.UpdateName(props.Name);
        item.UpdateCompleted(props.Completed);
        shoppingListItemRepository.UpdateAsync(item);
        return this.NoContent();
    }

    [HttpDelete("{id:guid}")]
    public async Task<ActionResult> Delete(Guid id)
    {
        var item = await shoppingListItemRepository.GetByIdAsync(id);
        NotFoundException.ThrowIfNull(item, ExceptionMessages.ShoppingListItemNotFoundMessage(id));
        shoppingListItemRepository.RemoveAsync(item);
        return this.NoContent();
    }
}