import 'package:flutter/material.dart';

class OptionsItemBuilder {
  OptionsItemBuilder({required String label}) : _label = label;

  final String _label;
  Color _color = Colors.white;
  BorderRadius _borderRadius = BorderRadius.circular(12);
  double _elevation = 2;
  IconData _icon = Icons.person;
  EdgeInsetsGeometry _padding = EdgeInsets.all(12);
  GestureTapCallback? _onClickHandler;

  OptionsItemBuilder withColor(Color color) {
    _color = color;
    return this;
  }

  OptionsItemBuilder withBorderRadius(BorderRadius borderRadius) {
    _borderRadius = borderRadius;
    return this;
  }

  OptionsItemBuilder withElevation(double elevation) {
    _elevation = 2;
    return this;
  }

  OptionsItemBuilder withIcon(IconData icon) {
    _icon = icon;
    return this;
  }

  OptionsItemBuilder withPadding(EdgeInsetsGeometry padding) {
    _padding = padding;
    return this;
  }

  OptionsItemBuilder withOnTapCallback(GestureTapCallback? callback) {
    _onClickHandler = callback;
    return this;
  }

  Material build() {
    return Material(
      color: _color,
      borderRadius: _borderRadius,
      elevation: _elevation,
      child: InkWell(
        onTap: _onClickHandler,
        borderRadius: _borderRadius,
        child: Container(
          padding: _padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(_icon, size: 32, color: Colors.teal),
              const SizedBox(height: 4),
              Text(_label, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
