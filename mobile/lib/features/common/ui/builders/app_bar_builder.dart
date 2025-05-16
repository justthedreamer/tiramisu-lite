import 'package:flutter/material.dart';

class AppBarBuilder {
  String _title = "Tiramisu-lite";
  Color _backgroundColor = Colors.teal;

  AppBarBuilder withTitle(String title) {
    _title = title;
    return this;
  }

  AppBarBuilder withBackgroundColor(Color color) {
    _backgroundColor = color;
    return this;
  }

  AppBar build() {
    return AppBar(title: Text(_title), backgroundColor: _backgroundColor);
  }
}
