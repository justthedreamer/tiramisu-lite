namespace tiramisu_lite.Mapping;

using AutoMapper;
using tiramisu_lite.DTO;
using tiramisu_lite.Model;
using Profile = AutoMapper.Profile;

[AutoMap(typeof(PlanerItem))]
public class PlanerItemProfile : Profile
{
    public PlanerItemProfile()
    {
        CreateMap<PlanerItem, PlanerItemDto>();
    }
}