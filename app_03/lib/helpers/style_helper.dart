// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m;

class Primary {
  static Color Background = const Color.fromARGB(255, 13, 104, 5);
  static Color Foreground = const Color.fromARGB(255, 214, 204, 204);
}

class Secondary {
  static Color Background = const Color.fromARGB(255, 162, 204, 158);
  static Color Foreground = const Color.fromARGB(255, 0, 0, 0);
}

class Style {
  static TextStyle Bold = const TextStyle(fontWeight: FontWeight.bold);
  static TextStyle Size(double size) => TextStyle(fontSize: size);
}

extension StyleExtensions on TextStyle {
  TextStyle Italic() => merge(const TextStyle(fontStyle: FontStyle.italic));
  TextStyle Size(double size) => merge(TextStyle(fontSize: size));
  TextStyle Color(m.Color color) => merge(TextStyle(color: color));
}

extension ColorExtension on Color {
  TextStyle Bold() => TextStyle(color: this, fontWeight: FontWeight.bold);
}