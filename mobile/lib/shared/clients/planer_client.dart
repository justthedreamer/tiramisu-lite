import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile/config/api_config.dart';
import 'package:mobile/model/dto/planer_item_dto.dart';
import 'package:mobile/model/planer.dart';
import 'package:mobile/model/planer_item.dart';

import '../helpers/client_helper.dart';

class PlanerClient {
  static Future<Planer> fetchPlaner(String profileName) async {
    const errorMessage = "Cannot fetch planner data right now.";
    try {
      final response = await http.get(
        ApiConfig.routes.planer.fetch(profileName),
      );

      if (response.statusCode == HttpStatus.ok) {
        return Planer.fromJson(jsonDecode(response.body));
      }

      throw Exception(HttpClientHelper.extractError(response, fallback: errorMessage));
    } catch (e) {
      throw Exception(errorMessage);
    }
  }

  static Future<void> addItem(String profileName, PlanerItemDto data) async {
    const errorMessage = "Cannot add planner item right now.";
    try {
      final response = await http.post(
        ApiConfig.routes.planer.createItem(profileName),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data.toJson()),
      );

      if (response.statusCode != HttpStatus.created) {
        throw Exception(HttpClientHelper.extractError(response, fallback: errorMessage));
      }
    } catch (e) {
      throw Exception(errorMessage);
    }
  }

  static Future<void> deleteItem(
      String profileName,
      PlanerItem planerItem,
      ) async {
    const errorMessage = "Cannot delete planner item.";
    try {
      final response = await http.delete(
        ApiConfig.routes.planer.deleteItem(profileName, planerItem.id),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != HttpStatus.noContent) {
        throw Exception(HttpClientHelper.extractError(response, fallback: errorMessage));
      }
    } catch (e) {
      throw Exception(errorMessage);
    }
  }

  static Future<void> updateItem(
      String profileName,
      PlanerItem planerItem,
      ) async {
    const errorMessage = "Cannot update planner item.";
    final body = {
      "title": planerItem.title,
      "eatDate": planerItem.eatTime.toUtc().toIso8601String(),
      "notify": planerItem.notify,
    };

    try {
      final response = await http.put(
        ApiConfig.routes.planer.updateItem(profileName, planerItem.id),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode != HttpStatus.noContent) {
        throw Exception(HttpClientHelper.extractError(response, fallback: errorMessage));
      }
    } catch (e) {
      throw Exception(errorMessage);
    }
  }
}
