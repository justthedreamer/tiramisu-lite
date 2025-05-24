import '../../../../model/dto/shopping_list_item_dto.dart';
import '../../../../shared/clients/shopping_list_item_client.dart';

class ShoppingListItemService {
  final String shoppingListId;

  ShoppingListItemService({required this.shoppingListId});

  Future<void> updateItem(String itemId, String name, bool completed) async {
    final dto = ShoppingListItemDto(name: name, completed: completed);
    await ShoppingListItemClient.updateItem(shoppingListId, itemId, dto);
  }

  Future<void> deleteItem(String itemId) async {
    await ShoppingListItemClient.deleteItem(shoppingListId, itemId);
  }
}
