namespace tiramisu_lite.Model;

public class Meal
{
    public Guid Id { get; private set; }
    public Guid PlanerItemId { get; private set; }
    public PlanerItem PlanerItem { get; init; } = null!;
    public string Name { get; private set; }
    public string Description { get; private set; }
    public decimal Kcal { get; private set; }

    public Meal(Guid id, Guid planerItemId, string name, string description, decimal kcal)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(name, nameof(name));
        ArgumentException.ThrowIfNullOrWhiteSpace(description, nameof(description));
        
        this.Id = id;
        this.PlanerItemId = planerItemId;
        this.Name = name;
        this.Description = description;
        this.Kcal = kcal;
    }

    public void UpdateName(string name)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(name, nameof(name));
        this.Name = name;
    }

    public void UpdateDescription(string description)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(description, nameof(description));
        this.Description = description;
    }

    public void UpdateKcal(decimal kcal)
    {
        this.Kcal = kcal;
    }
}