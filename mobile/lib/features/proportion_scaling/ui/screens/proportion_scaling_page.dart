import 'package:flutter/material.dart';

import '../../data/baking_form.dart';
import '../../data/ingredient.dart';
import '../../data/scaling.dart';
import '../../data/shape.dart';

class ProportionScalingPage extends StatefulWidget {
  const ProportionScalingPage({super.key});

  @override
  State<ProportionScalingPage> createState() => _ProportionScalingPageState();
}

class _ProportionScalingPageState extends State<ProportionScalingPage> {
  Shape originalShape = Shape.round;
  Shape targetShape = Shape.round;

  final _originalDiameterController = TextEditingController();
  final _originalWidthController = TextEditingController();
  final _originalLengthController = TextEditingController();
  final _originalDepthController = TextEditingController();

  final _targetDiameterController = TextEditingController();
  final _targetWidthController = TextEditingController();
  final _targetLengthController = TextEditingController();
  final _targetDepthController = TextEditingController();

  final List<TextEditingController> _nameControllers = [];
  final List<TextEditingController> _amountControllers = [];
  final List<TextEditingController> _unitControllers = [];

  List<Ingredient> scaledIngredients = [];

  static const List<String> units = ['g', 'kg', 'ml', 'l', 'pcs'];

  void _addIngredientField() {
    setState(() {
      _nameControllers.add(TextEditingController());
      _amountControllers.add(TextEditingController());
      _unitControllers.add(TextEditingController(text: units.first));
    });
  }

  void _calculateScaling() {
    final originalForm = originalShape == Shape.round
        ? BakingForm.round(
      diameter: double.tryParse(_originalDiameterController.text) ?? 0,
      depth: double.tryParse(_originalDepthController.text) ?? 0,
    )
        : BakingForm.rectangular(
      width: double.tryParse(_originalWidthController.text) ?? 0,
      length: double.tryParse(_originalLengthController.text) ?? 0,
      depth: double.tryParse(_originalDepthController.text) ?? 0,
    );

    final targetForm = targetShape == Shape.round
        ? BakingForm.round(
      diameter: double.tryParse(_targetDiameterController.text) ?? 0,
      depth: double.tryParse(_targetDepthController.text) ?? 0,
    )
        : BakingForm.rectangular(
      width: double.tryParse(_targetWidthController.text) ?? 0,
      length: double.tryParse(_targetLengthController.text) ?? 0,
      depth: double.tryParse(_targetDepthController.text) ?? 0,
    );

    final inputIngredients = List.generate(_nameControllers.length, (i) {
      return Ingredient(
        name: _nameControllers[i].text,
        amount: double.tryParse(_amountControllers[i].text) ?? 0,
        unit: _unitControllers[i].text,
      );
    });

    final result = scaleIngredients(
      originalForm: originalForm,
      targetForm: targetForm,
      ingredients: inputIngredients,
    );

    setState(() {
      scaledIngredients = result;
    });
  }

  Widget _buildFormFields({required bool isOriginal}) {
    final shape = isOriginal ? originalShape : targetShape;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButton<Shape>(
          value: isOriginal ? originalShape : targetShape,
          onChanged: (newValue) {
            setState(() {
              if (isOriginal) {
                originalShape = newValue!;
              } else {
                targetShape = newValue!;
              }
            });
          },
          items: Shape.values.map((shape) {
            return DropdownMenuItem(
              value: shape,
              child: Text(shape.name),
            );
          }).toList(),
        ),
        if (shape == Shape.round) ...[
          TextField(
            controller:
            isOriginal ? _originalDiameterController : _targetDiameterController,
            decoration: const InputDecoration(labelText: 'Diameter (cm)'),
            keyboardType: TextInputType.number,
          ),
        ] else ...[
          TextField(
            controller: isOriginal ? _originalWidthController : _targetWidthController,
            decoration: const InputDecoration(labelText: 'Width (cm)'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: isOriginal ? _originalLengthController : _targetLengthController,
            decoration: const InputDecoration(labelText: 'Length (cm)'),
            keyboardType: TextInputType.number,
          ),
        ],
        TextField(
          controller: isOriginal ? _originalDepthController : _targetDepthController,
          decoration: const InputDecoration(labelText: 'Depth (cm)'),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Proportion Scaling')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Original Form', style: TextStyle(fontWeight: FontWeight.bold)),
            _buildFormFields(isOriginal: true),
            const SizedBox(height: 16),
            const Text('Target Form', style: TextStyle(fontWeight: FontWeight.bold)),
            _buildFormFields(isOriginal: false),
            const SizedBox(height: 16),
            const Text('Ingredients', style: TextStyle(fontWeight: FontWeight.bold)),
            ...List.generate(_nameControllers.length, (i) {
              return Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: _nameControllers[i],
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _amountControllers[i],
                      decoration: const InputDecoration(labelText: 'Amount'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<String>(
                      value: _unitControllers[i].text.isNotEmpty && units.contains(_unitControllers[i].text)
                          ? _unitControllers[i].text
                          : units.first,
                      items: units.map((unit) {
                        return DropdownMenuItem(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (newUnit) {
                        setState(() {
                          _unitControllers[i].text = newUnit ?? units.first;
                        });
                      },
                      decoration: const InputDecoration(labelText: 'Unit'),
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _addIngredientField,
              child: const Text('Add Ingredient'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculateScaling,
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 24),
            if (scaledIngredients.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Scaled Ingredients:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...scaledIngredients.map((i) => Text("${i.name}: ${i.amount} ${i.unit}")),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
