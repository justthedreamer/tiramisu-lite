import 'package:flutter/material.dart';
import 'package:mobile/features/home/screens/home_page.dart';
import 'package:mobile/features/settings/screens/settings-screen.dart';
import 'package:mobile/shared/navigation/tools_navigator.dart';

import '../../../common/ui/builders/app_bar_builder.dart';
import '../../../options/data/option_config.dart';
import '../../../options/ui/builders/options_grid_builder.dart';
import '../../../options/ui/builders/options_header_builder.dart';
import '../../../options/ui/builders/options_item_builder.dart';
import '../../../options/ui/builders/options_wrapper_builder.dart';
import '../../../options/ui/logic/option_utils.dart';
import '../widgets/tools_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuilder().build(),
      body: const ToolsSection(),
    );
  }
}
