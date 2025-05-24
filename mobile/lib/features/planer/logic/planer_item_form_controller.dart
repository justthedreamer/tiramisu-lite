import 'package:flutter/material.dart';
import 'package:mobile/model/dto/meal_dto.dart';
import 'package:mobile/model/dto/planer_item_dto.dart';
import 'package:mobile/shared/clients/planer_client.dart';

class PlanerItemFormController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> titleKey = GlobalKey<FormFieldState>();

  final TextEditingController titleController = TextEditingController();
  TimeOfDay? _eatTime;

  bool notifyState = false;

  void setEatTime(TimeOfDay time) {
    _eatTime = time;
  }

  bool validateForm(BuildContext context, List<MealDto> meals) {
    final isTitleValid = titleKey.currentState?.validate() ?? false;
    final hasMeals = meals.isNotEmpty;
    final hasTime = _eatTime != null;

    if (!isTitleValid || !hasMeals || !hasTime) {
      String message = "Form contains errors.";
      if (!hasMeals) {
        message = "Please add at least one meal.";
      } else if (!hasTime) {
        message = "Please select an eating time.";
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      return false;
    }

    return true;
  }

  Future<void> submitPlanerItem({
    required BuildContext context,
    required String profileName,
    required DateTime eatDate,
    required List<MealDto> meals,
  }) async {
    try {
      final DateTime eatDateTime = DateTime(
        eatDate.year,
        eatDate.month,
        eatDate.day,
        _eatTime!.hour,
        _eatTime!.minute,
      );

      await PlanerClient.addItem(
        profileName,
        PlanerItemDto(
          props: PlanerItemProps(
            title: titleController.text,
            eatDate: eatDateTime,
            notify: notifyState,
          ),
          meals: meals,
        ),
      );

      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error: ${e.toString()}"),
      ));
    }
  }

  void dispose() {
    titleController.dispose();
  }
}

