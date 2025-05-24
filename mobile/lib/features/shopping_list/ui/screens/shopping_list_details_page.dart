import 'package:flutter/material.dart';
import 'package:mobile/features/shopping_list/ui/widgets/shopping_list_item_tile.dart';

import '../../../../state/shopping_list_state.dart';
import 'package:provider/provider.dart';
import '../../../../state/profile_state.dart';

class ShoppingListDetailsPage extends StatelessWidget {
  final String shoppingListId;

  const ShoppingListDetailsPage({
    super.key,
    required this.shoppingListId,
  });

  @override
  Widget build(BuildContext context) {
    final profileName = context.read<ProfileState>().activeProfile!.name;

    return ChangeNotifierProvider(
      create: (_) => ShoppingListState(profileName: profileName)..fetchListById(shoppingListId),
      child: const _ShoppingListDetailsView(),
    );
  }
}

class _ShoppingListDetailsView extends StatefulWidget {
  const _ShoppingListDetailsView();

  @override
  State<_ShoppingListDetailsView> createState() => _ShoppingListDetailsViewState();
}

class _ShoppingListDetailsViewState extends State<_ShoppingListDetailsView> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingListState>(
      builder: (context, state, _) {
        if (state.loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
        if (state.error != null) return Scaffold(body: Center(child: Text(state.error!)));
        final list = state.currentList;
        if (list == null) return const Scaffold(body: Center(child: Text('List not found')));

        _nameController.value = TextEditingValue(
          text: list.name,
          selection: TextSelection.collapsed(offset: list.name.length),
        );

        return Scaffold(
          appBar: AppBar(
            title: TextField(
              controller: _nameController,
              decoration: const InputDecoration(border: InputBorder.none),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              onSubmitted: (_) => state.updateListName(_nameController.text),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  final confirmed = await _confirmDeleteDialog(context);
                  if (confirmed == true) {
                    await state.deleteCurrentList();
                    if (context.mounted) Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
          body: list.items.isEmpty
              ? const Center(child: Text("No items in the list"))
              : ListView.builder(
            itemCount: list.items.length,
            itemBuilder: (context, index) {
              final item = list.items[index];
              return ShoppingListItemTile(
                item: item,
                onCompletedChanged: (_) => state.toggleItemCompleted(item),
                onEdit: () async {
                  final newName = await _editItemDialog(context, item.name);
                  if (newName != null) {
                    state.renameItem(item, newName);
                  }
                },
                onDelete: () => state.deleteItem(item),
              );
            },
          ),
        );
      },
    );
  }

  Future<String?> _addItemDialog(BuildContext context) {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add item"),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: "Item name"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(onPressed: () => Navigator.pop(context, controller.text.trim()), child: const Text("Add")),
        ],
      ),
    );
  }


  Future<String?> _editItemDialog(BuildContext context, String currentName) {
    final controller = TextEditingController(text: currentName);
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit item name'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Item name'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<bool?> _confirmDeleteDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete list?"),
        content: const Text("Are you sure you want to delete this shopping list?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text("Delete")),
        ],
      ),
    );
  }
}
