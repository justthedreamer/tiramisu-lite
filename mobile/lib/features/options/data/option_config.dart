import 'package:flutter/cupertino.dart';

class OptionConfig {
  final String label;
  final IconData icon;
  final Widget Function() destinationBuilder;

  OptionConfig({
    required this.label,
    required this.icon,
    required this.destinationBuilder,
  });
}