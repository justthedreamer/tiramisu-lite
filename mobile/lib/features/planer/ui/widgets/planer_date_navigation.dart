import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile/shared/helpers/date_helper.dart';
import 'package:mobile/state/planer_state.dart';

class PlanerDateNavigation extends StatelessWidget {
  const PlanerDateNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final planerState = context.watch<PlanerState>();
    final dateText = DateHelper.getDateWithoutTime(planerState.currentDate);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_left),
            onPressed: planerState.decrementDate,
          ),
          Text(
            dateText,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_right),
            onPressed: planerState.incrementDate,
          ),
        ],
      ),
    );
  }
}
