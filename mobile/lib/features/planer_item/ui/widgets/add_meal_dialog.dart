import 'package:flutter/material.dart';
import 'package:mobile/model/meal.dart';

class AddMealDialog extends StatefulWidget {
  final void Function(Meal meal) onAdd;

  const AddMealDialog({super.key, required this.onAdd});

  @override
  State<AddMealDialog> createState() => _AddMealDialogState();
}

class _AddMealDialogState extends State<AddMealDialog> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _kcalController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _kcalController.dispose();
    super.dispose();
  }

  void _handleAdd() {
    final name = _nameController.text.trim();
    final description = _descController.text.trim();
    final kcal = double.tryParse(_kcalController.text) ?? 0;

    if (name.isEmpty) return;

    final meal = Meal(
      id: "",
      name: name,
      description: description,
      kcal: kcal,
    );

    widget.onAdd(meal);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Meal"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Meal name"),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            TextField(
              controller: _kcalController,
              decoration: const InputDecoration(labelText: "Kcal"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _handleAdd,
          child: const Text("Add"),
        ),
      ],
    );
  }
}
