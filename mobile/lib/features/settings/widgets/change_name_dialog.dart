import 'package:flutter/material.dart';

import '../../../state/profile_state.dart';
import '../logic/change_profile_name_service.dart';

class ChangeProfileNameDialog extends StatefulWidget {
  final ProfileState profileState;
  final void Function(bool) onLoadingChanged;

  const ChangeProfileNameDialog({
    super.key,
    required this.profileState,
    required this.onLoadingChanged,
  });

  @override
  State<ChangeProfileNameDialog> createState() => _ChangeProfileNameDialogState();
}

class _ChangeProfileNameDialogState extends State<ChangeProfileNameDialog> {
  late final TextEditingController _controller;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final profile = widget.profileState.activeProfile!;
    _controller = TextEditingController(text: profile.name);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final newName = _controller.text.trim();
    if (newName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Name cannot be empty")),
      );
      return;
    }

    setState(() => _saving = true);
    widget.onLoadingChanged(true);

    final error = await ChangeProfileNameService.changeName(
      profileState: widget.profileState,
      newName: newName,
    );

    widget.onLoadingChanged(false);
    if (!mounted) return;

    setState(() => _saving = false);

    if (error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile name changed")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Change Profile Name"),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(hintText: "Enter new name"),
        enabled: !_saving,
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _saving ? null : _save,
          child: _saving
              ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
              : const Text("Save"),
        ),
      ],
    );
  }
}
