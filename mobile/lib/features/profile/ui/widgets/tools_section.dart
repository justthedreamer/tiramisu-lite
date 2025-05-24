import 'package:flutter/cupertino.dart';
import 'package:mobile/features/profile/ui/widgets/tools_option_item.dart';

import '../../../../shared/navigation/tools_navigator.dart';
import '../../../options/ui/builders/options_grid_builder.dart';
import '../../../options/ui/builders/options_header_builder.dart';
import '../../../options/ui/builders/options_wrapper_builder.dart';

class ToolsSection extends StatelessWidget {
  const ToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final optionConfigs = ToolsNavigator.getToolOptionConfigs(context);

    final toolOptions =
        optionConfigs.map((config) => ToolsOptionItem(config: config)).toList();

    return OptionsWrapperBuilder().build(
      header: OptionsHeaderBuilder(title: "Tools").build(),
      options: OptionsGridBuilder().withOptions(toolOptions).build(),
    );
  }
}
