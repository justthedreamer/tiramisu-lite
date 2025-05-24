import 'package:flutter/cupertino.dart';
import 'package:mobile/model/profile.dart';
import 'package:mobile/state/profile_state.dart';

import '../../../shared/clients/profile_client.dart';
import '../../../shared/helpers/scaffold_message_helper.dart';

class ChangeProfileNameService {
  static Future<String?> changeName({
    required ProfileState profileState,
    required String newName,
  }) async {
    final profile = profileState.activeProfile!;
    final requestProfile = Profile(
      name: newName,
      avatarBase64: profile.avatarBase64,
    );

    try {
      await ProfileClient.update(profile.name, requestProfile);
      profileState.setActiveProfile(requestProfile);
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}

