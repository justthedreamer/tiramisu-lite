namespace tiramisu_lite.Mapping;

using AutoMapper;
using tiramisu_lite.DTO;
using tiramisu_lite.Model;
using Profile = AutoMapper.Profile;

[AutoMap(typeof(Planer))]
public class PlanerProfile : Profile
{
    public PlanerProfile()
    {
        this.CreateMap<Planer, PlanerDto>();
    }
}