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
      title: json['title'],
      eatTime: DateTime.parse(json['eatTime']),
      meals:
          (json['meals'] as List).map((meal) => Meal.fromJson(meal)).toList(),
      kcalSummary: (json['kcalSummary']).toDouble(),
      notify: json['notify'],
    );
  }

  PlanerItem copyWith({
    String? id,
    String? title,
    DateTime? eatTime,
    List<Meal>? meals,
    double? kcalSummary,
    bool? notify,
  }) {
    return PlanerItem(
      id: id ?? this.id,
      title: title ?? this.title,
      eatTime: eatTime ?? this.eatTime,
      meals: meals ?? this.meals,
      kcalSummary: kcalSummary ?? this.kcalSummary,
      notify: notify ?? this.notify,
    );
  }
}
