import 'package:flutter/material.dart';
import 'package:app_03/loader.dart';

void main() {
  runApp(MaterialApp(
    title: "Conversor de Moedas",
    debugShowCheckedModeBanner: false,
    home: const Loader(),
    theme: ThemeData(
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateColor.resolveWith((states) => Colors.black),
          padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.all(15)),
          side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(width: 2))
        )
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(borderSide: BorderSide.none)
      )
    )
  ));
}