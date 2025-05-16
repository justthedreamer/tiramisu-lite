import 'package:flutter/material.dart';
import 'package:mobile/state/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../shared/navigation/profile_navigator.dart';
import '../../common/ui/builders/app_bar_builder.dart';
import '../widgets/create_profile_fab.dart';
import '../widgets/profiles_grid_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<ProfileState>().fetchProfiles(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<ProfileState>();

    return Scaffold(
      appBar: AppBarBuilder().build(),
      body: RefreshIndicator(
        onRefresh: () => context.read<ProfileState>().fetchProfiles(),
        child: ProfilesSection(profileState: profileState),
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
