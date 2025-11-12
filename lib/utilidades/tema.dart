import 'package:flutter/material.dart';

class TemaApp {
  static ThemeData temaPadrao = ThemeData(
    primarySwatch: Colors.blueGrey,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Color(0xFF455A64),
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF455A64),
    ),
  );
}
