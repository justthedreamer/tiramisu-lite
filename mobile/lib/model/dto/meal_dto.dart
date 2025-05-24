class MealDto {
  final String name;
  final String description;
  final double kcal;

  MealDto({required this.name, required this.description, required this.kcal});

  Map<String, dynamic> toJson() {
    return {'name': name, 'description': description, 'kcal': kcal};
  }
}
