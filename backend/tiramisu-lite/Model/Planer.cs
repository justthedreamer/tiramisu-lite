namespace tiramisu_lite.Model;

public class Planer(Guid id)
{
    public Guid Id { get; private set; } = id;
    public Profile Profile { get; private set; } = null!;
    public IEnumerable<PlanerItem> Items => this.items;
    private List<PlanerItem> items = [];
}