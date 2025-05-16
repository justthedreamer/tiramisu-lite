import 'dart:io';

class ApiConfig {
  static const String baseUrl = "http://10.0.2.2:5217/api";

  static String get profiles => '$baseUrl/profiles';
}
