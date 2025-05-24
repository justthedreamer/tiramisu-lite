import 'package:mobile/config/route_aggregate.dart';

class ShoppingListItemRoutes extends RouteAggregate {
  ShoppingListItemRoutes({required super.baseUrl});

  Uri fetchOne(String shoppingListId, String itemId) =>
      Uri.parse('$baseUrl/shopping-lists/$shoppingListId/items/$itemId');

  Uri create(String shoppingListId) =>
      Uri.parse('$baseUrl/shopping-lists/$shoppingListId/items');

  Uri update(String shoppingListId, String itemId) =>
      Uri.parse('$baseUrl/shopping-lists/$shoppingListId/items/$itemId');

  Uri delete(String shoppingListId, String itemId) =>
      Uri.parse('$baseUrl/shopping-lists/$shoppingListId/items/$itemId');
}