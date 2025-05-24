import '../../../../shared/clients/shopping_list_client.dart';

class ShoppingListService {
  final String profileName;

  ShoppingListService({required this.profileName});

  Future<void> updateName(String listId, String newName) async {
    await ShoppingListClient.updateShoppingList(profileName, listId, newName);
  }

  Future<void> deleteList(String listId) async {
    await ShoppingListClient.deleteShoppingList(profileName, listId);
  }
}

