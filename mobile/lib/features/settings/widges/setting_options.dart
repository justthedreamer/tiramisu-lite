import 'package:flutter/material.dart';
import 'package:mobile/features/settings/widges/change_name_dialog.dart';
import 'package:mobile/features/settings/widges/delete_profile_dialog.dart';
import 'package:mobile/features/settings/widges/setting_option_tile.dart';
import 'package:mobile/state/profile_state.dart';
import 'package:provider/provider.dart';

import '../../../model/profile.dart';

class SettingOptions extends StatelessWidget {
  const SettingOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<ProfileState>();
    final profile = profileState.activeProfile!;
    return Column(
      children: [
        SettingsOptionTile(
          icon: Icons.edit,
          title: "Change profile name",
          onTap: () => _showChangeProfileNameDialog(context, profileState),
        ),
        SettingsOptionTile(
          icon: Icons.delete,
          title: "Delete profile",
          onTap: () => _showDeleteProfileDialog(context, profileState),
        ),
      ],
    );
  }

  void _showChangeProfileNameDialog(
    BuildContext context,
    ProfileState profileState,
  ) {
    showDialog(
      context: context,
      builder: (context) => ChangeProfileNameDialog(profileState: profileState),
    );
  }

  void _showDeleteProfileDialog(
    BuildContext context,
    ProfileState profileState,
  ) {
    showDialog(
      context: context,
      builder: (context) => DeleteProfileDialog(profileState: profileState),
    );
  }
}
