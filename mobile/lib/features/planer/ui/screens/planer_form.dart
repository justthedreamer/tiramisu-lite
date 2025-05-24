import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile/features/planer/ui/widgets/meal_form.dart';
import 'package:mobile/features/planer/ui/widgets/meal_tile.dart';
import 'package:mobile/features/planer/logic/planer_item_form_controller.dart';
import 'package:mobile/state/planer_state.dart';
import 'package:mobile/state/profile_state.dart';
import 'package:mobile/model/dto/meal_dto.dart';
import 'package:mobile/shared/form/form_time_picker_input.dart';
import 'package:mobile/shared/form/form_builder.dart';
import 'package:mobile/shared/helpers/container_helper.dart';
import 'package:mobile/shared/helpers/validation_helper.dart';

class PlanerForm extends StatefulWidget {
  const PlanerForm({super.key});

  @override
  State<PlanerForm> createState() => _PlanerFormState();
}

class _PlanerFormState extends State<PlanerForm> {
  final controller = PlanerItemFormController();
  final List<MealDto> meals = [];

  @override
  Widget build(BuildContext context) {
    final planerState = context.watch<PlanerState>();
    final profileState = context.read<ProfileState>();

    return Scaffold(
      appBar: AppBar(title: const Text("Planer item")),
      body: SingleChildScrollView(
        padding: ContainerHelper.getCommonEdgeInsets(),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormBuilder.buildFormHeader("Planer item form"),

              FormBuilder.buildTextInput(
                key: controller.titleKey,
                label: "Title",
                controller: controller.titleController,
                validator:
                    (value) => ValidationHelper.EnsureStringNotEmpty(
                      value,
                      errorMessage: "Title cannot be empty.",
                    ),
              ),

              FormBuilder.buildSpacing(),

              TimePickerInput(
                label: "Eat time",
                initialTime: TimeOfDay.now(),
                onTimeChanged: controller.setEatTime,
              ),

              FormBuilder.buildSpacing(),

              SwitchListTile(
                title: const Text("Enable notifications"),
                value: controller.notifyState,
                onChanged:
                    (value) => setState(() => controller.notifyState = value),
              ),

              FormBuilder.buildSpacing(),

              FormBuilder.buildFormSubHeader("Meals"),
              FormBuilder.buildSpacing(),

              // Meal list
              if (meals.isEmpty)
                Container(
                  constraints: const BoxConstraints(minHeight: 150),
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: const Text(
                    "Add meals to the list",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              else
                Column(
                  children:
                      meals
                          .map(
                            (meal) => MealTile(
                              meal: meal,
                              onDelete:
                                  () => setState(() => meals.remove(meal)),
                            ),
                          )
                          .toList(),
                ),

              // Meal Form controls
              MealForm(onAdd: (meal) => setState(() => meals.add(meal))),

              FormBuilder.buildExpandedSubmitButton(
                label: "Add planer item",
                onPressed:
                    () => _submit(
                      context,
                      profileState.activeProfile!.name,
                      planerState.currentDate,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit(
    BuildContext context,
    String profileName,
    DateTime eatDate,
  ) async {
    if (!controller.validateForm(context, meals)) return;

    await controller.submitPlanerItem(
      context: context,
      profileName: profileName,
      eatDate: eatDate,
      meals: meals,
    );
  }
}
