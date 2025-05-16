import 'package:flutter/material.dart';

import '../../data/option_config.dart';
import '../builders/options_item_builder.dart';

List<Material> getOptions(
    BuildContext context,
    List<OptionConfig> optionConfigs,
    ) {
  return optionConfigs.map((config) {
    return OptionsItemBuilder(
      label: config.label,
    ).withIcon(config.icon).withOnTapCallback(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => config.destinationBuilder()),
      );
    }).build();
  }).toList();
}