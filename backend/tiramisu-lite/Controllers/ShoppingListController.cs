namespace tiramisu_lite.Controllers;

using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using tiramisu_lite.Controllers.Requests;
using tiramisu_lite.DTO;
using tiramisu_lite.Exceptions;
using tiramisu_lite.Model;
using tiramisu_lite.Repositories;

[Route("api/profiles/{profileName}/shopping-lists")]
public class ShoppingListController(
    IProfileRepository profileRepository,
    IShoppingListRepository shoppingListRepository,
    IMapper mapper)
    : ControllerBase
{
    [HttpGet]
    public async Task<ActionResult<ShoppingListDto>> GetAll(string profileName)
    {
        var list = await shoppingListRepository
            .GetAllAsync(shoppingList => shoppingList.Profile.Name == profileName);
        var dto = list.Select(mapper.Map<ShoppingList, ShoppingListDto>);
        return this.Ok(dto);
    }

    [HttpGet("{id:guid}")]
    public async Task<ActionResult<ShoppingListDto>> GetById(Guid id)
    {
        var list = await shoppingListRepository.GetByIdAsync(id);
        NotFoundException.ThrowIfNull(list, ExceptionMessages.ShoppingListNotFoundMessage(id));
        var dto = mapper.Map<ShoppingListDto>(list);
        return this.Ok(dto);
    }

    [HttpPost]
    public async Task<ActionResult> Create(
        string profileName,
        [FromBody] ShoppingListCreateData request)
    {
        var itemId = Guid.NewGuid();
        var profile = await profileRepository.GetByNameAsync(profileName);
        NotFoundException.ThrowIfNull(profile, ExceptionMessages.ProfileNotFoundMessage(profileName));
        var item = new ShoppingList(itemId, profile.Id, request.Name, DateTime.Now)
        {
            ShoppingListItems = request.Items
                .Select(item => new ShoppingListItem(Guid.NewGuid(), itemId, item.Name, item.Completed)),
        };
        await shoppingListRepository.AddAsync(item);
        return this.Created();
    }

    [HttpPut("{id:guid}")]
    public async Task<ActionResult> Update(
        Guid id,
        [FromBody] ShoppingListProps props)
    {
        var list = await shoppingListRepository.GetByIdAsync(id);
        NotFoundException.ThrowIfNull(list, ExceptionMessages.ShoppingListNotFoundMessage(id));
        list.UpdateName(props.Name);
        await shoppingListRepository.UpdateAsync(list);
        return this.NoContent();
    }

    [HttpDelete("{id:guid}")]
    public async Task<ActionResult> Delete(Guid id)
    {
        var list = await shoppingListRepository.GetByIdAsync(id);
        NotFoundException.ThrowIfNull(list, ExceptionMessages.ShoppingListNotFoundMessage(id));
        await shoppingListRepository.RemoveAsync(list);
        return this.NoContent();
    }
}