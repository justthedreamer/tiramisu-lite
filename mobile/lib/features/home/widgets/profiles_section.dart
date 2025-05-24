import 'package:flutter/material.dart';
import 'package:mobile/features/options/ui/builders/options_header_builder.dart';
import 'package:mobile/features/options/ui/builders/options_wrapper_builder.dart';
import 'package:provider/provider.dart';

import '../../../model/profile.dart';
import '../../../shared/navigation/profile_navigator.dart';
import '../../../state/profile_state.dart';
import '../../options/ui/builders/options_grid_builder.dart';
import '../../options/ui/builders/options_item_builder.dart';

class ProfilesSection extends StatefulWidget {
  const ProfilesSection({super.key});

  @override
  State<ProfilesSection> createState() => _ProfilesSectionState();
}

class _ProfilesSectionState extends State<ProfilesSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileState>().fetchProfiles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<ProfileState>();

    if (profileState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (profileState.error != null) {
      return _ErrorView(
        message: profileState.error!,
        onRetry: () => context.read<ProfileState>().fetchProfiles(),
      );
    }

    if (profileState.profiles.isEmpty) {
      return const _EmptyView();
    }

    return _ProfilesGrid(profiles: profileState.profiles);
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: onRetry, child: const Text("Retry")),
        ],
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    var header = OptionsHeaderBuilder(title: "Profiles").build();

    var content = const Padding(
      padding: EdgeInsets.all(16),
      child: Text("Profile list is empty."),
    );

    var wrapper = OptionsWrapperBuilder().build(
      header: header,
      options: content,
    );

    return wrapper;
  }
}

class _ProfilesGrid extends StatelessWidget {
  final List<Profile> profiles;

  const _ProfilesGrid({required this.profiles});

  @override
  Widget build(BuildContext context) {
    final items =
        profiles.map((profile) {
          return OptionsItemBuilder(
            label: profile.name,
          ).withIcon(Icons.person).withOnTapCallback(() {
            ProfileNavigator.openProfile(
              context: context,
              destination: profile,
            );
          }).build();
        }).toList();

    final header = OptionsHeaderBuilder(title: "Profiles").build();
    final grid = OptionsGridBuilder().withOptions(items).build();
    return OptionsWrapperBuilder().build(header: header, options: grid);
  }
}
