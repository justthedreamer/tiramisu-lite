import 'package:flutter/material.dart';

class OptionsGridBuilder {
  List<Material> _options = [];

  OptionsGridBuilder withOptions(List<Material> options) {
    _options = options;
    return this;
  }

  GridView build() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 3 / 2,
      ),
      itemCount: _options.length,
      itemBuilder: (context, index) => _options[index],
    );
  }
}