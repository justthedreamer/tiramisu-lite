import 'package:flutter/material.dart';
import 'package:mobile/shared/helpers/date_helper.dart';
import 'package:provider/provider.dart';

import '../../../../state/planer_item_state.dart';

class EditableEatTime extends StatelessWidget {
  final String profileName;
  final DateTime eatTime;

  const EditableEatTime({
    super.key,
    required this.profileName,
    required this.eatTime,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Eat time: ${DateHelper.getTimeWithoutDate(eatTime)}',
            style: const TextStyle(fontSize: 18),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () async {
            final newTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(eatTime),
            );
            if (newTime != null) {
              final updatedDateTime = DateTime(
                eatTime.year,
                eatTime.month,
                eatTime.day,
                newTime.hour,
                newTime.minute,
              );
              await context.read<PlanerItemState>().updateEatTime(
                profileName,
                updatedDateTime,
              );
            }
          },
        ),
      ],
    );
  }
}
