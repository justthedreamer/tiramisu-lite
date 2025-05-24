import 'package:http/http.dart' as http;

class HttpClientHelper {
  static String extractError(
    http.Response response, {
    required String fallback,
  }) {
    return response.body.isNotEmpty ? response.body : fallback;
  }
}
