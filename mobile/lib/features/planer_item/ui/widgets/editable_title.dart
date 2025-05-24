import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../state/planer_item_state.dart';

class EditableTitle extends StatelessWidget {
  final String profileName;
  final String title;

  const EditableTitle({super.key, required this.profileName, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Title: $title",
            style: const TextStyle(fontSize: 18),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () async {
            final newTitle = await _showEditTitleDialog(context, title);
            if (newTitle != null && newTitle.isNotEmpty) {
              await context.read<PlanerItemState>().updateTitle(profileName, newTitle);
            }
          },
        ),
      ],
    );
  }

  Future<String?> _showEditTitleDialog(BuildContext context, String currentTitle) {
    final controller = TextEditingController(text: currentTitle);

    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Title'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
