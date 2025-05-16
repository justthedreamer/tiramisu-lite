import 'package:flutter/cupertino.dart';
import 'package:mobile/model/profile.dart';
import 'package:mobile/state/profile_provider.dart';

import '../../../shared/clients/profile_client.dart';
import '../../../shared/helpers/scaffold_message_helper.dart';

class ChangeProfileNameService {
  static Future<void> changeName({
    required BuildContext context,
    required ProfileState profileState,
    required String newName,
  }) async {
    final profile = profileState.activeProfile!;

    var requestProfile = Profile(
      name: newName,
      avatarBase64: profile.avatarBase64,
    );

    final result = await ProfileClient.update(profile.name, requestProfile);

    if (result) {
      profileState.setActiveProfile(requestProfile);
      if (context.mounted) {
        ScaffoldMessageHelper.showSnackBar(context, "Profile name changed");
        Navigator.pop(context);
      }
      return;
    } else if (context.mounted) {
      ScaffoldMessageHelper.showSnackBar(
        context,
        "Failed to change profile name",
      );
    }
  }
}
