// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

TextStyle title_font = const TextStyle(
  decoration: TextDecoration.none,
  color: Colors.white,
  fontSize: 45,
  fontWeight: FontWeight.bold,
  shadows: [
    Shadow(
      color: Colors.black, 
      offset: Offset(5, 5), 
      blurRadius: 0.5
    )
  ]
);

TextStyle label_font = const TextStyle(
  decoration: TextDecoration.none,
  color: Colors.white,
  fontSize: 30,
  fontWeight: FontWeight.bold
);

ButtonStyle button_style = OutlinedButton.styleFrom(
  side: const BorderSide(
    width: 2.5,
    color: Colors.black
  ),
  backgroundColor: const Color.fromARGB(255, 101, 155, 255),
  padding: const EdgeInsets.all(20)
);