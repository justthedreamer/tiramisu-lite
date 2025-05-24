import 'package:flutter/cupertino.dart';

class PlanerItemCardSummary extends StatelessWidget {
  final double kcalSummary;

  const PlanerItemCardSummary({super.key,required this.kcalSummary});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '$kcalSummary kcal',
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}