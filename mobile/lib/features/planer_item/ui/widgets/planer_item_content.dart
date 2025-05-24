import 'package:flutter/material.dart';
import 'package:mobile/features/planer_item/ui/widgets/planer_item_meal_list.dart';
import 'package:mobile/shared/helpers/scaffold_message_helper.dart';
import 'package:provider/provider.dart';

import '../../../../state/planer_item_state.dart';
import '../../../../state/planer_state.dart';
import '../../../../state/profile_state.dart';
import 'editable_eat_time.dart';
import 'editable_title.dart';
import 'notification_toggle.dart';

class PlanerItemContent extends StatelessWidget {
  final String profileName;

  const PlanerItemContent({super.key, required this.profileName});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlanerItemState>(
      builder: (context, state, _) {
        final item = state.item;

        if (item == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NotificationToggle(profileName: profileName),
              const SizedBox(height: 16),
              EditableTitle(profileName: profileName, title: item.title),
              const SizedBox(height: 12),
              EditableEatTime(profileName: profileName, eatTime: item.eatTime),
              const SizedBox(height: 16),
              const Expanded(child: PlanerItemMealList()),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () => _handleDelete(context),
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Deletion"),
        content: const Text("Are you sure you want to delete this item?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Delete")),
        ],
      ),
    );

    if (confirmed != true) return;

    final error = await context.read<PlanerItemState>().deleteItem(profileName);
    if (error != null) {
      ScaffoldMessageHelper.showSnackBar(context, "Failed to delete item: $error");
    } else {
      if (context.mounted) {
        final profile = context.read<ProfileState>().activeProfile;
        if (profile != null) {
          await context.read<PlanerState>().fetchPlaner(profile.name);
        }
        Navigator.pop(context); // return to previous screen
      }
    }
  }
}
