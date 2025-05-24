import 'package:flutter/foundation.dart';
import 'package:mobile/model/dto/shopping_list_item_dto.dart';
import '../model/dto/shopping_list_dto.dart';
import '../model/shopping_list.dart';
import '../model/shopping_list_item.dart';
import '../shared/clients/shopping_list_client.dart';
import '../shared/clients/shopping_list_item_client.dart';
import '../features/shopping_list/logic/services/shopping_list_service.dart';

class ShoppingListState extends ChangeNotifier {
  final String profileName;
  final ShoppingListService _listService;
  List<ShoppingList> _lists = [];
  ShoppingList? currentList;
  bool loading = false;
  String? error;

  ShoppingListState({required this.profileName})
    : _listService = ShoppingListService(profileName: profileName);

  List<ShoppingList> get lists => _lists;

  void _startLoading() {
    loading = true;
    error = null;
    notifyListeners();
  }

  void _endLoading() {
    loading = false;
    notifyListeners();
  }

  Future<void> fetchLists() async {
    _startLoading();
    try {
      _lists = await ShoppingListClient.fetchShoppingLists(profileName);
    } catch (e) {
      error = e.toString();
    }
    _endLoading();
  }

  Future<void> fetchListById(String id) async {
    _startLoading();
    try {
      currentList = await ShoppingListClient.fetchShoppingListById(
        profileName,
        id,
      );
    } catch (e) {
      error = e.toString();
    }
    _endLoading();
  }

  Future<void> updateListName(String newName) async {
    if (currentList == null ||
        newName.trim().isEmpty ||
        newName == currentList!.name) {
      return;
    }
    try {
      await _listService.updateName(currentList!.id, newName);
      currentList = currentList!.copyWith(name: newName);
      notifyListeners();
    } catch (e) {
      error = "Failed to update name: $e";
      notifyListeners();
    }
  }

  Future<void> toggleItemCompleted(ShoppingListItem item) async {
    if (currentList == null) return;
    final updated = item.copyWith(completed: !item.completed);
    try {
      await ShoppingListItemClient.updateItem(
        currentList!.id,
        item.id,
        updated.toDto(),
      );
      _updateItemInList(updated);
    } catch (e) {
      error = "Failed to update item status: $e";
      notifyListeners();
    }
  }

  Future<void> renameItem(ShoppingListItem item, String newName) async {
    if (currentList == null || newName.trim().isEmpty || newName == item.name) {
      return;
    }
    final updated = item.copyWith(name: newName);
    try {
      await ShoppingListItemClient.updateItem(
        currentList!.id,
        item.id,
        updated.toDto(),
      );
      _updateItemInList(updated);
    } catch (e) {
      error = "Failed to rename item: $e";
      notifyListeners();
    }
  }

  Future<void> deleteItem(ShoppingListItem item) async {
    if (currentList == null) return;
    try {
      await ShoppingListItemClient.deleteItem(currentList!.id, item.id);
      currentList = currentList!.copyWith(
        items: currentList!.items.where((i) => i.id != item.id).toList(),
      );
      notifyListeners();
    } catch (e) {
      error = "Failed to delete item: $e";
      notifyListeners();
    }
  }

  void _updateItemInList(ShoppingListItem updated) {
    currentList = currentList!.copyWith(
      items:
          currentList!.items
              .map((i) => i.id == updated.id ? updated : i)
              .toList(),
    );
    notifyListeners();
  }

  void updateList(ShoppingList updatedList) {
    final index = _lists.indexWhere((l) => l.id == updatedList.id);
    if (index >= 0) {
      _lists[index] = updatedList;
      notifyListeners();
    }
  }

  Future<void> deleteCurrentList() async {
    if (currentList == null) return;
    try {
      await ShoppingListClient.deleteShoppingList(profileName, currentList!.id);
      currentList = null;
      notifyListeners();
    } catch (e) {
      error = "Failed to delete list: $e";
      notifyListeners();
    }
  }

  Future<void> addItemToCurrentList(String name) async {
    if (currentList == null) return;
    try {
      final newItem = ShoppingListItemDto(name: name, completed: false);
      await ShoppingListItemClient.createItemWithReturn(currentList!.id, newItem);
      await fetchListById(currentList!.id);
      notifyListeners();
    } catch (e) {
      error = "Failed to add item: $e";
      notifyListeners();
    }
  }

  Future<void> addShoppingList(ShoppingListDto dto) async {
    try {
      await ShoppingListClient.addShoppingList(profileName, dto);
      await fetchLists();
      notifyListeners();
    } catch (e) {
      error = "Failed to add list: $e";
      notifyListeners();
    }
  }

}
