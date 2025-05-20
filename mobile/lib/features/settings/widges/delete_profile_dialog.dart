import 'package:flutter/material.dart';
import 'package:mobile/features/settings/logic/profile_delete_service.dart';
import 'package:mobile/state/profile_state.dart';

import '../../../model/profile.dart';

class DeleteProfileDialog extends StatelessWidget {
  final ProfileState profileState;

  const DeleteProfileDialog({super.key, required this.profileState});

  @override
  Widget build(BuildContext context) {
    final profile = profileState.activeProfile!;
    return AlertDialog(
      title: const Text("Delete profile"),
      content: const Text(
        "Are you sure you want to delete this profile? This action cannot be undone.",
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed:
              () => ProfileDeleteService.deleteProfile(context, profile.name),
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
