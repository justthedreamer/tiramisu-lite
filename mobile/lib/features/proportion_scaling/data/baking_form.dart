import 'package:mobile/features/proportion_scaling/data/shape.dart';

class BakingForm {
  final Shape shape;
  final double depth; // cm
  final double? diameter;
  final double? width;
  final double? length;

  BakingForm.round({
    required this.diameter,
    required this.depth,
  })  : shape = Shape.round,
        width = null,
        length = null;

  BakingForm.rectangular({
    required this.width,
    required this.length,
    required this.depth,
  })  : shape = Shape.rectangular,
        diameter = null;

  double get volumeCm3 {
    switch (shape) {
      case Shape.round:
        final radius = (diameter! / 2);
        return 3.1416 * radius * radius * depth;
      case Shape.rectangular:
        return width! * length! * depth;
    }
  }
}