import 'package:flutter/material.dart';
import 'package:mobile/features/planer/screen/planer_page.dart';

import '../../features/home/screens/home_page.dart';
import '../../features/options/data/option_config.dart';
import '../../features/settings/screens/settings-screen.dart';

class ToolsNavigator {
  static List<OptionConfig> getToolOptionConfigs(BuildContext context) {
    return [
      OptionConfig(
        label: "Planer",
        icon: Icons.calendar_today,
        destinationBuilder: () => PlanerPage(),
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
}


