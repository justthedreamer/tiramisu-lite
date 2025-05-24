import 'package:flutter/material.dart';

import '../../../state/profile_state.dart';
import '../logic/profile_delete_service.dart';

class DeleteProfileDialog extends StatefulWidget {
  final ProfileState profileState;
  final void Function(bool) onLoadingChanged;

  const DeleteProfileDialog({
    super.key,
    required this.profileState,
    required this.onLoadingChanged,
  });

  @override
  State<DeleteProfileDialog> createState() => _DeleteProfileDialogState();
}

class _DeleteProfileDialogState extends State<DeleteProfileDialog> {
  bool _deleting = false;

  Future<void> _delete() async {
    setState(() => _deleting = true);
    widget.onLoadingChanged(true);

    final profileName = widget.profileState.activeProfile!.name;
    final error = await ProfileDeleteService.deleteProfile(
      profileState: widget.profileState,
      profileName: profileName,
    );

    widget.onLoadingChanged(false);
    if (!mounted) return;

    setState(() => _deleting = false);

    if (error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile deleted")),
      );
      Navigator.pushReplacementNamed(context, '/home'); // lub Twoja nawigacja
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete profile"),
      content: const Text(
        "Are you sure you want to delete this profile? This action cannot be undone.",
      ),
      actions: [
        TextButton(
          onPressed: _deleting ? null : () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _deleting ? null : _delete,
          child: _deleting
              ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
              : const Text("Delete"),
        ),
      ],
    );
  }
}
