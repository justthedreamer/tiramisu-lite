import 'package:mobile/model/meal.dart';

class PlanerItem {
  final String id;
  final String title;
  final DateTime eatTime;
  final List<Meal> meals;
  final double kcalSummary;
  final bool notify;

  const PlanerItem({
    required this.id,
    required this.title,
    required this.eatTime,
    required this.meals,
    required this.kcalSummary,
    required this.notify,
  });

  factory PlanerItem.fromJson(Map<String, dynamic> json) {
    return PlanerItem(
      id: json['id'],
      title: json['name'],
      eatTime: DateTime.parse(json['eatTime']),
      meals:
          (json['meals'] as List).map((meal) => Meal.fromJson(meal)).toList(),
      kcalSummary: json['kcalSummary'],
      notify: json['notify'],
    );
  }
}
