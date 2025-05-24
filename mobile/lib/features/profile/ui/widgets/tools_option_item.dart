import 'package:flutter/material.dart';

import '../../../options/data/option_config.dart';
import '../../../options/ui/builders/options_item_builder.dart';

class ToolsOptionItem extends StatelessWidget {
  final OptionConfig config;

  const ToolsOptionItem({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return OptionsItemBuilder(
      label: config.label,
    ).withIcon(config.icon).withOnTapCallback(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => config.destinationBuilder()),
      );
    }).build();
  }
}
