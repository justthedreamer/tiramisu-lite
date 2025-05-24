import 'package:flutter/material.dart';

import '../../../../model/shopping_list.dart';

class ShoppingListWidget extends StatelessWidget {
  final ShoppingList shoppingList;
  final VoidCallback onTap;

  const ShoppingListWidget({
    super.key,
    required this.shoppingList,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(shoppingList.name),
        subtitle: Text(
            "${shoppingList.items.length} items · Created: ${shoppingList.createdAt.toLocal().toString().split(' ')[0]}"),
        trailing: Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}
