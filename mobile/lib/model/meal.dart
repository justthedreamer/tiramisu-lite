class Meal {
  final String id;
  final String name;
  final String description;
  final double kcal;

  Meal({
    required this.id,
    required this.name,
    required this.description,
    required this.kcal,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      kcal: (json['kcal'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'kcal': kcal,
    };
  }
}
