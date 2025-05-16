import 'package:flutter/material.dart';
import 'package:mobile/features/home/screens/home_page.dart';
import 'package:mobile/features/settings/screens/settings-screen.dart';

import '../../common/ui/builders/app_bar_builder.dart';
import '../../options/data/option_config.dart';
import '../../options/ui/builders/options_grid_builder.dart';
import '../../options/ui/builders/options_header_builder.dart';
import '../../options/ui/builders/options_wrapper_builder.dart';
import '../../options/ui/logic/option_utils.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  List<OptionConfig> getOptionConfigs(BuildContext context) {
    return [
      OptionConfig(
        label: "Planer",
        icon: Icons.calendar_today,
        destinationBuilder: () => HomePage(),
      ),
      OptionConfig(
        label: "Shopping List",
        icon: Icons.shopping_cart,
        destinationBuilder: () => HomePage(),
      ),
      OptionConfig(
        label: "Gramature Scaling",
        icon: Icons.scale,
        destinationBuilder: () => HomePage(),
      ),
      OptionConfig(
        label: "Proportion Scaling",
        icon: Icons.aspect_ratio,
        destinationBuilder: () => HomePage(),
      ),
      OptionConfig(
        label: "Settings",
        icon: Icons.settings,
        destinationBuilder: () => SettingsScreen(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder().build(),
      body: OptionsWrapperBuilder.buildOptionsWrapper(
        header: OptionsHeaderBuilder(title: "Tools").build(),
        options:
            OptionsGridBuilder()
                .withOptions(getOptions(context, getOptionConfigs(context)))
                .build(),
      ),
    );
  }
}
