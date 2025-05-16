namespace tiramisu_lite.Mapping;

using AutoMapper;
using tiramisu_lite.DTO;

[AutoMap(typeof(Model.Profile))]
public class ProfileProfile : Profile
{
    public ProfileProfile()
    {
        this.CreateMap<Model.Profile, ProfileDto>();
    }
}