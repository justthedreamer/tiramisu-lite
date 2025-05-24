import 'package:flutter/material.dart';
import 'package:mobile/features/profile/ui/screens/profile_page.dart';
import 'package:mobile/model/profile.dart';
import 'package:mobile/state/profile_state.dart';
import 'package:provider/provider.dart';

import '../../features/home/screens/profile_form_page.dart';

class ProfileNavigator {
  static Future<bool> openCreateProfile({required BuildContext context}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CreateProfilePage()),
    );
    return result == true;
  }

  static Future<bool> openProfile({
    required BuildContext context,
    required Profile destination,
  }) async {
    final profileState = context.read<ProfileState>();
    profileState.setActiveProfile(destination);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProfilePage()),
    );
    return result == true;
  }
}
