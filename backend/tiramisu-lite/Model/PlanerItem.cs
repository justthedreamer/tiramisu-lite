namespace tiramisu_lite.Model;

public class PlanerItem
{
    public Guid Id { get; set; }
    public Guid PlanerId { get; set; }
    public Planer Planer { get; init; } = null!;
    public string Title { get; set; }
    public DateTime EatTime { get; set; }
    public bool Notify { get; set; }

    public required IEnumerable<Meal> Meals
    {
        get => this.meals;
        init => this.meals = value.ToList();
    }

    public decimal KcalSummary => this.meals.Sum(s => s.Kcal);
    private List<Meal> meals = [];

    public PlanerItem(Guid id, Guid planerId, string title, DateTime eatTime, bool notify = false)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(title);
        this.Id = id;
        this.PlanerId = planerId;
        this.Title = title;
        this.EatTime = eatTime;
        this.Notify = notify;
    }


    public void UpdateTitle(string title)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(title, nameof(title));
        this.Title = title;
    }

    public void UpdateEatTime(DateTime eatTime)
    {
        this.EatTime = eatTime;
    }

    public void UpdateNotify(bool notify)
    {
        this.Notify = notify;
    }
}