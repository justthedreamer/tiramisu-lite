import 'package:flutter/material.dart';

import '../../../../shared/helpers/date_helper.dart';

class PlanerItemCardHeader extends StatelessWidget {
  final String title;
  final DateTime eatTime;
  final bool notify;

  const PlanerItemCardHeader({
    super.key,
    required this.title,
    required this.eatTime,
    required this.notify,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                DateHelper.getTimeWithoutDate(eatTime),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.notifications_active,
          color: notify ? Colors.blue : Colors.grey,
        ),
        const SizedBox(height: 4),
        const Divider(),
        const SizedBox(height: 4),
      ],
    );
  }
}
