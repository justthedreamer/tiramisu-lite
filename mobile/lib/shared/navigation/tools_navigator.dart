import 'package:flutter/material.dart';
import 'package:mobile/features/proportion_scaling/ui/screens/proportion_scaling_page.dart';
import 'package:mobile/features/shopping_list/ui/screens/shopping_list_page.dart';

import '../../features/options/data/option_config.dart';
import '../../features/planer/ui/screens/planer_page.dart';
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
        destinationBuilder: () => ShoppingListPage(),
      ),
      OptionConfig(
        label: "Proportion Scaling",
        icon: Icons.aspect_ratio,
        destinationBuilder: () => ProportionScalingPage(),
      ),
      OptionConfig(
        label: "Settings",
        icon: Icons.settings,
        destinationBuilder: () => SettingsPage(),
      ),
    ];
  }
}
