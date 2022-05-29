// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;

class Primary {
  static Color Background = const Color.fromARGB(255, 13, 104, 5);
  static Color Foreground = const Color.fromARGB(255, 214, 204, 204);

  static ButtonStyle ForegroundButtonStyle(bool state)
  {
    Color color = state ? Colors.white : Colors.transparent;
    return ButtonStyle(
      side: MaterialStateBorderSide.resolveWith((states) => BorderSide(width: 2, color: color)),
      foregroundColor: MaterialStateColor.resolveWith((states) => color)
    );
  }
}

class Secondary {
  static Color Background = const Color.fromARGB(255, 162, 204, 158);
  static Color Foreground = const Color.fromARGB(255, 0, 0, 0);
}

class Style {
  static TextStyle Bold = const TextStyle(fontWeight: FontWeight.bold);
  static TextStyle Size(double size) => TextStyle(fontSize: size);
  static TextStyle Color(m.Color color) => TextStyle(color: color);
}

extension StyleExtensions on TextStyle {
  TextStyle Italic() => merge(const TextStyle(fontStyle: FontStyle.italic));
  TextStyle Size(double size) => merge(TextStyle(fontSize: size));
  TextStyle Color(m.Color color) => merge(TextStyle(color: color));
}

extension ColorExtension on Color {
  TextStyle Bold() => TextStyle(color: this, fontWeight: FontWeight.bold);
}