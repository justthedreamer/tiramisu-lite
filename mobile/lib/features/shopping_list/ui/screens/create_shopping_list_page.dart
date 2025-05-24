import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/dto/shopping_list_dto.dart';
import '../../../../model/dto/shopping_list_item_dto.dart';
import '../../../../state/shopping_list_state.dart';

class CreateShoppingListPage extends StatefulWidget {
  const CreateShoppingListPage({super.key});

  @override
  State<CreateShoppingListPage> createState() => _CreateShoppingListPageState();
}

class _CreateShoppingListPageState extends State<CreateShoppingListPage> {
  final _formKey = GlobalKey<FormState>();
  final _listNameController = TextEditingController();
  final _itemNameController = TextEditingController();

  final List<ShoppingListItemDto> _items = [];

  @override
  void dispose() {
    _listNameController.dispose();
    _itemNameController.dispose();
    super.dispose();
  }

  void _addItem() {
    final itemName = _itemNameController.text.trim();
    if (itemName.isEmpty) return;
    setState(() {
      _items.add(ShoppingListItemDto(name: itemName, completed: false));
      _itemNameController.clear();
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least one item')),
      );
      return;
    }

    final shoppingListDto = ShoppingListDto(
      name: _listNameController.text.trim(),
      items: _items,
    );

    final state = context.read<ShoppingListState>();
    await state.addShoppingList(shoppingListDto);

    if (state.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create list: ${state.error}')),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Shopping List')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _listNameController,
                decoration: const InputDecoration(labelText: 'List Name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'List name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _itemNameController,
                      decoration: const InputDecoration(labelText: 'Item Name'),
                      onFieldSubmitted: (_) => _addItem(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addItem,
                  )
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (_, index) {
                    final item = _items[index];
                    return ListTile(
                      title: Text(item.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _items.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
