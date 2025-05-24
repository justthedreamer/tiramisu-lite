import 'package:flutter/material.dart';
import 'package:mobile/shared/helpers/scaffold_message_helper.dart';
import 'package:provider/provider.dart';

import '../../../../state/planer_item_state.dart';

class NotificationToggle extends StatelessWidget {
  final String profileName;

  const NotificationToggle({super.key, required this.profileName});

  @override
  Widget build(BuildContext context) {
    final notify = context.select<PlanerItemState, bool>(
      (state) => state.item?.notify ?? false,
    );

    return Row(
      children: [
        const Expanded(
          child: Text("Notifications", style: TextStyle(fontSize: 18)),
        ),
        IconButton(
          icon: Icon(
            notify ? Icons.notifications_active : Icons.notifications_off,
          ),
          onPressed: () => _handleToggleNotify(context),
        ),
      ],
    );
  }

  Future<void> _handleToggleNotify(BuildContext context) async {
    final error = await context.read<PlanerItemState>().toggleNotify(
      profileName,
    );
    if (error != null && context.mounted) {
      ScaffoldMessageHelper.showSnackBar(
        context,
        "Failed to update notification: $error",
      );
    }
  }
}
