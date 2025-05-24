import 'package:flutter/material.dart';
import 'package:mobile/model/dto/meal_dto.dart';

class MealTile extends StatelessWidget {
  final MealDto meal;
  final VoidCallback onDelete;

  const MealTile({
    super.key,
    required this.meal,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(meal.name),
        subtitle: Text('${meal.kcal} kcal\n${meal.description}'),
        isThreeLine: true,
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
