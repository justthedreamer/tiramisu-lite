import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile/config/api_config.dart';
import 'package:mobile/model/dto/shopping_list_dto.dart';
import 'package:mobile/model/shopping_list.dart';
import 'package:mobile/shared/helpers/client_helper.dart';

class ShoppingListClient {
  static Future<List<ShoppingList>> fetchShoppingLists(String profileName) async {
    const errorMessage = "Failed to load shopping lists.";
    try {
      final response = await http.get(
        ApiConfig.routes.shoppingList.fetch(profileName),
      );

      if (response.statusCode == HttpStatus.ok) {
        final decoded = json.decode(response.body) as List;
        return decoded.map((e) => ShoppingList.fromJson(e)).toList();
      }

      throw Exception(HttpClientHelper.extractError(response, fallback: errorMessage));
    } catch (_) {
      throw Exception(errorMessage);
    }
  }

  static Future<ShoppingList> fetchShoppingListById(String profileName, String id) async {
    const errorMessage = "Failed to fetch shopping list.";
    try {
      final response = await http.get(
        ApiConfig.routes.shoppingList.fetchById(profileName, id),
      );

      if (response.statusCode == HttpStatus.ok) {
        final decoded = json.decode(response.body);
        print(decoded);
        return ShoppingList.fromJson(decoded);
      }

      throw Exception(HttpClientHelper.extractError(response, fallback: errorMessage));
    } catch (_) {
      throw Exception(errorMessage);
    }
  }

  static Future<void> addShoppingList(String profileName, ShoppingListDto shoppingList) async {
    const errorMessage = "Failed to create shopping list.";
    try {
      final response = await http.post(
        ApiConfig.routes.shoppingList.create(profileName),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(shoppingList.toJson()),
      );

      if (response.statusCode != HttpStatus.created) {
        throw Exception(HttpClientHelper.extractError(response, fallback: errorMessage));
      }
    } catch (_) {
      throw Exception(errorMessage);
    }
  }

  static Future<void> updateShoppingList(String profileName, String listId, String newName) async {
    const errorMessage = "Failed to update shopping list.";
    try {
      final response = await http.put(
        ApiConfig.routes.shoppingList.update(profileName, listId),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': newName}),
      );

      if (response.statusCode != HttpStatus.noContent) {
        throw Exception(HttpClientHelper.extractError(response, fallback: errorMessage));
      }
    } catch (_) {
      throw Exception(errorMessage);
    }
  }

  static Future<void> deleteShoppingList(String profileName, String listId) async {
    const errorMessage = "Failed to delete shopping list.";
    try {
      final response = await http.delete(
        ApiConfig.routes.shoppingList.delete(profileName, listId),
      );

      if (response.statusCode != HttpStatus.noContent) {
        throw Exception(HttpClientHelper.extractError(response, fallback: errorMessage));
      }
    } catch (_) {
      throw Exception(errorMessage);
    }
  }
}
