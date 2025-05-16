import 'package:flutter/material.dart';
import 'package:mobile/features/home/screens/home_page.dart';
import 'package:mobile/shared/helpers/scaffold_message_helper.dart';

import '../../../shared/clients/profile_client.dart';

class ProfileDeleteService {
  static Future<void> deleteProfile(
    BuildContext context,
    String profileName,
  ) async {
    final result = await ProfileClient.delete(profileName);
    if (!context.mounted) {
      return;
    }

    if (result) {
      ScaffoldMessageHelper.showSnackBar(context, "Profile deleted");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
      return;
    }
    ScaffoldMessageHelper.showSnackBar(context, "Failed to delete profile");
  }
}
