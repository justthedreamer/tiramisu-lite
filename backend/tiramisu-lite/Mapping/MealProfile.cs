namespace tiramisu_lite.Mapping;

using AutoMapper;
using tiramisu_lite.DTO;
using tiramisu_lite.Model;
using Profile = AutoMapper.Profile;

[AutoMap(typeof(Meal))]
public class MealProfile : Profile
{
    public MealProfile()
    {
        this.CreateMap<Meal, MealDto>();
    }
}