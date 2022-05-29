import 'package:flutter/material.dart';

class CenterText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const CenterText(this.text, { this.style, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style, textAlign: TextAlign.center);
  }
}