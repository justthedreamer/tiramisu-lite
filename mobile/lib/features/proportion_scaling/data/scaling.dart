import 'baking_form.dart';
import 'ingredient.dart';

List<Ingredient> scaleIngredients({
  required BakingForm originalForm,
  required BakingForm targetForm,
  required List<Ingredient> ingredients,
}) {
  final originalVolume = originalForm.volumeCm3;
  final targetVolume = targetForm.volumeCm3;

  if (originalVolume == 0) return ingredients;

  final scaleFactor = targetVolume / originalVolume;

  return ingredients.map((ingredient) {
    return ingredient.copyWith(
      amount: double.parse((ingredient.amount * scaleFactor).toStringAsFixed(2)),
    );
  }).toList();
}
