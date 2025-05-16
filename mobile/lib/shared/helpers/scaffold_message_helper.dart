import 'package:flutter/material.dart';

class ScaffoldMessageHelper {
  static Future<void> showSnackBar(BuildContext context, String message) async {
    if (!context.mounted) {
      debugPrint("Unable to push message, context unmounted.");
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
