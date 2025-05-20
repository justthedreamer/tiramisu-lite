import 'package:flutter/material.dart';
import 'package:mobile/features/settings/logic/change_profile_name_service.dart';
import 'package:mobile/state/profile_state.dart';

class ChangeProfileNameDialog extends StatelessWidget {
  final ProfileState profileState;

  const ChangeProfileNameDialog({super.key, required this.profileState});

  @override
  Widget build(BuildContext context) {
    final profile = profileState.activeProfile!;
    final controller = TextEditingController(text: profile.name);

    return AlertDialog(
      title: const Text("Change Profile Name"),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: profile.name),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            ChangeProfileNameService.changeName(
              context: context,
              profileState: profileState,
              newName: controller.text,
            );
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
