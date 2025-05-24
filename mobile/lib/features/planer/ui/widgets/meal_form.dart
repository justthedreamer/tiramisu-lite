import 'package:flutter/material.dart';
import 'package:mobile/model/dto/meal_dto.dart';
import 'package:mobile/shared/form/form_builder.dart';
import 'package:mobile/shared/helpers/validation_helper.dart';

class MealForm extends StatefulWidget {
  final void Function(MealDto meal) onAdd;

  const MealForm({super.key, required this.onAdd});

  @override
  State<MealForm> createState() => _MealFormState();
}

class _MealFormState extends State<MealForm> {
  final _nameKey = GlobalKey<FormFieldState>();
  final _descKey = GlobalKey<FormFieldState>();
  final _kcalKey = GlobalKey<FormFieldState>();

  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _kcalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilder.buildTextInput(
          key: _nameKey,
          label: "Meal name",
          controller: _nameController,
          validator: (value) => ValidationHelper.EnsureStringNotEmpty(value),
        ),
        FormBuilder.buildSpacing(),
        FormBuilder.buildTextInput(
          key: _descKey,
          label: "Description",
          controller: _descController,
          validator: (value) => ValidationHelper.EnsureStringNotEmpty(value),
        ),
        FormBuilder.buildSpacing(),
        FormBuilder.buildTextInput(
          key: _kcalKey,
          label: "Kcal",
          controller: _kcalController,
          validator: (value) => ValidationHelper.EnsurePositiveNumber(value),
        ),
        FormBuilder.buildSpacing(),
        FormBuilder.buildExpandedSubmitButton(
          label: "Add meal",
          onPressed: _addMeal,
        ),
      ],
    );
  }

  void _addMeal() {
    if (!(_nameKey.currentState?.validate() ?? false) ||
        !(_descKey.currentState?.validate() ?? false) ||
        !(_kcalKey.currentState?.validate() ?? false)) {
      return;
    }

    widget.onAdd(MealDto(
      name: _nameController.text,
      description: _descController.text,
      kcal: double.tryParse(_kcalController.text) ?? 0,
    ));

    _nameController.clear();
    _descController.clear();
    _kcalController.clear();
  }
}