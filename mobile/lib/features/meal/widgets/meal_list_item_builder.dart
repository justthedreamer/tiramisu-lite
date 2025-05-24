import 'package:flutter/material.dart';

import '../../../model/meal.dart';

class MealListItemBuilder {
  final Meal meal;
  final bool withDeleteIcon;
  final VoidCallback? onDelete;

  MealListItemBuilder({
    required this.meal,
    this.withDeleteIcon = false,
    this.onDelete,
  });

  Widget build() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('${meal.kcal} kcal'),
                Text(meal.description),
              ],
            ),
          ),
          if (withDeleteIcon && onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.grey),
              onPressed: onDelete,
            ),
        ],
      ),
    );
  }
}
