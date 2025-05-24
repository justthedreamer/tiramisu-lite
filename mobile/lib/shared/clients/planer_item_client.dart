import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile/config/api_config.dart';
import 'package:mobile/model/planer_item.dart';
import '../helpers/client_helper.dart';

class PlanerItemClient {
  static Future<List<PlanerItem>> fetchItems(String profileName) async {
    const errorMessage = "Cannot fetch planner items right now.";
    try {
      final response = await http.get(
        ApiConfig.routes.planerItem.fetchItems(profileName),
      );

      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => PlanerItem.fromJson(json)).toList();
      }

      throw Exception(
        HttpClientHelper.extractError(response, fallback: errorMessage),
      );
    } catch (e) {
      throw Exception(errorMessage);
    }
  }

  static Future<void> addItem(String profileName, PlanerItem item) async {
    const errorMessage = "Cannot add planner item right now.";

    final body = {
      "props": {
        "title": item.title,
        "eatDate": item.eatTime.toUtc().toIso8601String(),
        "notify": item.notify,
      },
      "meals":
          item.meals
              .map(
                (meal) => {
                  "name": meal.name,
                  "description": meal.description,
                  "kcal": meal.kcal,
                },
              )
              .toList(),
    };

    try {
      final response = await http.post(
        ApiConfig.routes.planerItem.createItem(profileName),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode != HttpStatus.created) {
        throw Exception(
          HttpClientHelper.extractError(response, fallback: errorMessage),
        );
      }
    } catch (e) {
      throw Exception(errorMessage);
    }
  }

  static Future<void> updateItem(String profileName, PlanerItem item) async {
    const errorMessage = "Cannot update planner item.";
    final body = {
      "title": item.title,
      "eatDate": item.eatTime.toIso8601String(),
      "notify": item.notify,
    };

    try {
      final response = await http.put(
        ApiConfig.routes.planerItem.updateItem(profileName, item.id),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode != HttpStatus.noContent) {
        throw Exception(
          HttpClientHelper.extractError(response, fallback: errorMessage),
        );
      }
    } catch (e) {
      throw Exception(errorMessage);
    }
  }

  static Future<void> deleteItem(String profileName, String itemId) async {
    const errorMessage = "Cannot delete planner item.";
    try {
      final response = await http.delete(
        ApiConfig.routes.planerItem.deleteItem(profileName, itemId),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != HttpStatus.noContent) {
        throw Exception(
          HttpClientHelper.extractError(response, fallback: errorMessage),
        );
      }
    } catch (e) {
      throw Exception(errorMessage);
    }
  }

  static Future<PlanerItem> fetchItem(String profileName, String itemId) async {
    const errorMessage = "Cannot fetch planner item right now.";
    try {
      final response = await http.get(
        ApiConfig.routes.planerItem.fetchItem(profileName, itemId),
      );

      if (response.statusCode == HttpStatus.ok) {
        return PlanerItem.fromJson(jsonDecode(response.body));
      }

      throw Exception(
        HttpClientHelper.extractError(response, fallback: errorMessage),
      );
    } catch (e) {
      throw Exception(errorMessage);
    }
  }
}
