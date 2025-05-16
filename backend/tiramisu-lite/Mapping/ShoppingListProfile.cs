namespace tiramisu_lite.Mapping;

using AutoMapper;
using tiramisu_lite.DTO;
using tiramisu_lite.Model;
using Profile = AutoMapper.Profile;

[AutoMap(typeof(ShoppingListItem))]
public class ShoppingListProfile : Profile
{
    public ShoppingListProfile()
    {
        this.CreateMap<ShoppingList, ShoppingListItemDto>();
    }
}