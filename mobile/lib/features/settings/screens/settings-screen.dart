import 'package:flutter/material.dart';
import 'package:mobile/features/common/ui/builders/app_bar_builder.dart';
import 'package:mobile/features/settings/widgets/profile_header.dart';
import 'package:provider/provider.dart';

import '../../../state/profile_state.dart';
import '../widgets/change_name_dialog.dart';
import '../widgets/delete_profile_dialog.dart';
import '../widgets/setting_option_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<ProfileState>();
    final profile = profileState.activeProfile!;

    return Scaffold(
      appBar: AppBarBuilder().withTitle("Settings").build(),
      body: Material(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(16), child: ProfileHeader()),
            SettingsOptionTile(
              icon: Icons.edit,
              title: "Change profile name",
              onTap: () => _showChangeProfileNameDialog(profileState),
            ),
            SettingsOptionTile(
              icon: Icons.delete,
              title: "Delete profile",
              onTap: () => _showDeleteProfileDialog(profileState),
            ),
            if (_loading) ...[
              const SizedBox(height: 12),
              const CircularProgressIndicator(),
            ],
          ],
        ),
      ),
    );
  }

  void _showChangeProfileNameDialog(ProfileState profileState) {
    showDialog(
      context: context,
      builder:
          (context) => ChangeProfileNameDialog(
            profileState: profileState,
            onLoadingChanged: _setLoading,
          ),
    );
  }

  void _showDeleteProfileDialog(ProfileState profileState) {
    showDialog(
      context: context,
      builder:
          (context) => DeleteProfileDialog(
            profileState: profileState,
            onLoadingChanged: _setLoading,
          ),
    );
  }

  void _setLoading(bool value) {
    if (mounted) {
      setState(() {
        _loading = value;
      });
    }
  }
}
