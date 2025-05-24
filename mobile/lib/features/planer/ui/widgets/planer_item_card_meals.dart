import 'package:flutter/cupertino.dart';
import 'package:mobile/model/meal.dart';

class PlanerItemCardMeals extends StatelessWidget {
  final List<Meal> meals;

  const PlanerItemCardMeals({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return Column(children: _buildList());
  }

  List<Widget> _buildList() {
    return meals.map((meal) => _buildItem(meal)).toList();
  }

  Widget _buildItem(Meal meal) {
    var header = meals.length == 1 ? "1 meal" : '${meals.length} meals';
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  header,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(child: Text(meal.name)),
              Text('${meal.kcal} kcal'),
            ],
          ),
        ],
      ),
    );
  }
}
