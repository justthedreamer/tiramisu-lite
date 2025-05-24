import 'package:flutter/material.dart';

import '../../../../model/shopping_list_item.dart';

class ShoppingListItemTile extends StatelessWidget {
  final ShoppingListItem item;
  final ValueChanged<bool?> onCompletedChanged;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ShoppingListItemTile({
    super.key,
    required this.item,
    required this.onCompletedChanged,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: item.completed,
        onChanged: onCompletedChanged,
      ),
      title: Text(
        item.name,
        style: TextStyle(
          decoration: item.completed ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(icon: Icon(Icons.edit), onPressed: onEdit),
          IconButton(icon: Icon(Icons.delete), onPressed: onDelete),
        ],
      ),
    );
  }
}
