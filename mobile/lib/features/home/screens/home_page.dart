import 'package:flutter/material.dart';
import 'package:mobile/state/profile_state.dart';
import 'package:provider/provider.dart';

import '../../../shared/navigation/profile_navigator.dart';
import '../../common/ui/builders/app_bar_builder.dart';
import '../widgets/create_profile_fab.dart';
import '../widgets/profiles_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder().withTitle("Profiles").build(),
      body: RefreshIndicator(
        onRefresh: () => context.read<ProfileState>().fetchProfiles(),
        child: SizedBox.expand(child: ProfilesSection()),
      ),
      floatingActionButton: CreateProfileFab(
        onPressed: () => _openCreateProfilePage(context),
      ),
    );
  }

  Future<void> _openCreateProfilePage(BuildContext context) async {
    final created = await ProfileNavigator.openCreateProfile(context: context);
    if (created && context.mounted) {
      await context.read<ProfileState>().fetchProfiles();
    }
  }
}