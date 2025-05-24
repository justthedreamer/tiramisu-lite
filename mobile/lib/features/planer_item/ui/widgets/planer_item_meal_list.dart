import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../state/planer_item_state.dart';
import 'package:mobile/model/meal.dart';

class PlanerItemMealList extends StatelessWidget {
  const PlanerItemMealList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlanerItemState>(
      builder: (context, state, _) {
        final meals = state.item?.meals ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _MealsHeader(),
            const SizedBox(height: 8),
            if (meals.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("No meals added."),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: meals.length,
                  itemBuilder: (context, index) {
                    final meal = meals[index];
                    return _MealCard(meal: meal);
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}

class _MealsHeader extends StatelessWidget {
  const _MealsHeader();

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Meals:",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class _MealCard extends StatelessWidget {
  final Meal meal;

  const _MealCard({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        title: Text(meal.name),
        subtitle: Text("${meal.kcal} kcal\n${meal.description}"),
        isThreeLine: true,
      ),
    );
  }
}
