import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../../config/api_config.dart';
import '../../model/dto/shopping_list_item_dto.dart';
import '../../model/shopping_list_item.dart';
import '../helpers/client_helper.dart';

class ShoppingListItemClient {
  static Future<ShoppingListItem> fetchItem(String shoppingListId, String itemId) async {
    const errorMessage = "Failed to fetch shopping list item.";
    try {
      final response = await http.get(
        ApiConfig.routes.shoppingListItems.fetchOne(shoppingListId, itemId),
      );

      if (response.statusCode == HttpStatus.ok) {
        return ShoppingListItem.fromJson(json.decode(response.body));
      }

      throw Exception(HttpClientHelper.extractError(response, fallback: errorMessage));
    } catch (_) {
      throw Exception(errorMessage);
    }
  }

  static Future<void> createItem(String shoppingListId, ShoppingListItemDto dto) async {
    const errorMessage = "Failed to create shopping list item.";
    try {
      final response = await http.post(
        ApiConfig.routes.shoppingListItems.create(shoppingListId),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dto.toJson()),
      );

      if (response.statusCode != HttpStatus.created) {
        throw Exception(HttpClientHelper.extractError(response, fallback: errorMessage));
      }
    } catch (_) {
      throw Exception(errorMessage);
    }
  }

  static Future<void> updateItem(String shoppingListId, String itemId, ShoppingListItemDto dto) async {
    const errorMessage = "Failed to update shopping list item.";
    try {
      final response = await http.put(
        ApiConfig.routes.shoppingListItems.update(shoppingListId, itemId),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dto.toJson()),
      );

      if (response.statusCode != HttpStatus.noContent) {
        throw Exception(HttpClientHelper.extractError(response, fallback: errorMessage));
      }
    } catch (_) {
      throw Exception(errorMessage);
    }
  }

  static Future<void> deleteItem(String shoppingListId, String itemId) async {
    const errorMessage = "Failed to delete shopping list item.";
    try {
      final response = await http.delete(
        ApiConfig.routes.shoppingListItems.delete(shoppingListId, itemId),
      );

      if (response.statusCode != HttpStatus.noContent) {
        throw Exception(HttpClientHelper.extractError(response, fallback: errorMessage));
      }
    } catch (_) {
      throw Exception(errorMessage);
    }
  }

  static Future<ShoppingListItem> createItemWithReturn(String shoppingListId, ShoppingListItemDto dto) async {
    const errorMessage = "Failed to create shopping list item.";
    try {
      final response = await http.post(
        ApiConfig.routes.shoppingListItems.create(shoppingListId),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(dto.toJson()),
      );

      if (response.statusCode == HttpStatus.created || response.statusCode == HttpStatus.ok) {
        return ShoppingListItem.fromJson(json.decode(response.body));
      }

      throw Exception(HttpClientHelper.extractError(response, fallback: errorMessage));
    } catch (_) {
      throw Exception(errorMessage);
    }
  }
}
