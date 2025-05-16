import 'package:flutter/material.dart';
import 'package:mobile/shared/navigation/profile_navigator.dart';
import 'package:mobile/state/profile_provider.dart';

import '../../../model/profile.dart';
import '../../options/ui/builders/options_grid_builder.dart';
import '../../options/ui/builders/options_header_builder.dart';
import '../../options/ui/builders/options_item_builder.dart';
import '../../options/ui/builders/options_wrapper_builder.dart';

class ProfilesSection extends StatelessWidget {
  final ProfileState profileState;

  const ProfilesSection({super.key, required this.profileState});

  @override
  Widget build(BuildContext context) {
    final profiles = profileState.profiles;
    final header = OptionsHeaderBuilder(title: "Profiles").build();
    final items = _buildProfileItems(context, profiles);
    final grid = OptionsGridBuilder().withOptions(items).build();

    return OptionsWrapperBuilder.buildOptionsWrapper(
      header: header,
      options: grid,
    );
  }

  List<Material> _buildProfileItems(
    BuildContext context,
    List<Profile> profiles,
  ) {
    return profiles.map((profile) {
      return OptionsItemBuilder(label: profile.name)
          .withIcon(Icons.person)
          .withOnTapCallback(
            () => ProfileNavigator.openProfile(
              context: context,
              destination: profile,
            ),
          )
          .build();
    }).toList();
  }
}
