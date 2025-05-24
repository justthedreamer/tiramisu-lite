import 'package:mobile/model/dto/meal_dto.dart';

class PlanerItemDto {
  final PlanerItemProps props;
  final List<MealDto> meals;

  PlanerItemDto({required this.props, required this.meals});

  Map<String, dynamic> toJson() {
    return {
      'props': props.toJson(),
      'meals': meals.map((meal) => meal.toJson()).toList(),
    };
  }
}


class PlanerItemProps {
  final String title;
  final DateTime eatDate;
  final bool notify;

  PlanerItemProps({
    required this.title,
    required this.eatDate,
    required this.notify,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'eatDate': eatDate.toIso8601String(),
      'notify': notify,
    };
  }
}

