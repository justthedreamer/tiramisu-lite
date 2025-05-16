import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/config/api_config.dart';
import 'package:mobile/model/profile.dart';

class ProfileClient {
  static Future<List<Profile>> fetch() async {
    final response = await http.get((Uri.parse(ApiConfig.profiles)));

    if (response.statusCode == HttpStatus.ok) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Profile.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load profiles");
    }
  }

  static Future<bool> update(String profileName,Profile profile) async {
    try {
      final response = await http.put(
        Uri.parse("${ApiConfig.profiles}/$profileName"),
        headers: {HttpHeaders.contentTypeHeader: ContentType.json.toString()},
        body: jsonEncode(profile),
      );

      if (response.statusCode == HttpStatus.noContent) {
        return true;
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<bool> create(Profile profile) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.profiles),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(profile),
      );

      if (response.statusCode == HttpStatus.created) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<bool> delete(String profileName) async {
    try {
      var url = Uri.parse("${ApiConfig.profiles}/$profileName");
      final response = await http.delete(url);

      if (response.statusCode == HttpStatus.noContent) {
        return true;
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
