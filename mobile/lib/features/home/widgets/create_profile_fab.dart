import 'package:flutter/material.dart';

class CreateProfileFab extends StatelessWidget {
  final VoidCallback onPressed;

  const CreateProfileFab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: "Create profile",
      child: const Icon(Icons.add),
    );
  }
}
