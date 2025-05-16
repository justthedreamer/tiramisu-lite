import 'package:flutter/cupertino.dart';

class OptionsHeaderBuilder {
  OptionsHeaderBuilder({required this.title});

  String title;
  TextStyle _textStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  OptionsHeaderBuilder withStyle(TextStyle style) {
    _textStyle = style;
    return this;
  }

  Text build() {
    return Text(title, style: _textStyle);
  }
}