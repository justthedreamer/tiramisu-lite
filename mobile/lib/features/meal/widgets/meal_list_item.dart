import 'package:flutter/cupertino.dart';
import 'package:mobile/model/meal.dart';

class MealListItem extends StatelessWidget {
  final Meal meal;

  const MealListItem({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text(meal.name)),
              Text(meal.kcal.toString()),
            ],
          ),
          Row(children: [Expanded(child: Text(meal.description))]),
        ],
      ),
    );
  }
}
