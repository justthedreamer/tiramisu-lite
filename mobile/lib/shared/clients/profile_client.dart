import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile/config/api_config.dart';
import 'package:mobile/model/profile.dart';

import '../helpers/client_helper.dart';

class ProfileClient {
  static Future<List<Profile>> fetch() async {
    const errorMessage = "Failed to load profiles.";
    try {
      final response = await http.get(ApiConfig.routes.profile.fetch());

      if (response.statusCode == HttpStatus.ok) {
        final jsonList = json.decode(response.body) as List;
        return jsonList.map((json) => Profile.fromJson(json)).toList();
      }

      throw Exception(HttpClientHelper.extractError(response, fallback: errorMessage));
    } catch (_) {
      throw Exception(errorMessage);
    }
  }

  static Future<void> create(Profile profile) async {
    const errorMessage = "Failed to create profile.";
    try {
      final response = await http.post(
        ApiConfig.routes.profile.create(),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(profile),
      );

      if (response.statusCode != HttpStatus.created) {
        throw Exception(HttpClientHelper.extractError(response, fallback: errorMessage));
      }
    } catch (_) {
      throw Exception(errorMessage);
    }
  }

  static Future<void> update(String profileName, Profile profile) async {
    const errorMessage = "Failed to update profile.";
    try {
      final response = await http.put(
        ApiConfig.routes.profile.update(profileName),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(profile),
      );

      if (response.statusCode != HttpStatus.noContent) {
        throw Exception(HttpClientHelper.extractError(response, fallback: errorMessage));
      }
    } catch (_) {
      throw Exception(errorMessage);
    }
  }

  static Future<void> delete(String profileName) async {
    const errorMessage = "Failed to delete profile.";
    try {
      final response = await http.delete(
        ApiConfig.routes.profile.delete(profileName),
      );

      if (response.statusCode != HttpStatus.noContent) {
        throw Exception(HttpClientHelper.extractError(response, fallback: errorMessage));
      }
    } catch (_) {
      throw Exception(errorMessage);
    }
  }
  
}