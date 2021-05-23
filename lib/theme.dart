import 'package:flutter/material.dart';

class AppTheme {
  final Color _accentColor;
  final Color _secondary;
  final Color _secondaryVariant;

  AppTheme(
      {Color accentColor = const Color.fromARGB(255, 113, 96, 243),
      Color secondary = const Color(0xffee2ee2),
      Color secondaryVariant = const Color(0xffa42fdb)})
      : _accentColor = accentColor,
        _secondary = secondary,
        _secondaryVariant = secondaryVariant;

  ThemeData getLightTheme() {
    return ThemeData.light().copyWith(
        accentColor: _accentColor,
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black87),
        ),
        buttonColor: _accentColor,
        colorScheme: ColorScheme.light().copyWith(
          primary: _accentColor,
          secondary: _secondary,
          secondaryVariant: _secondaryVariant,
        ));
  }

  ThemeData getDarkTheme() => ThemeData.dark().copyWith(
      accentColor: _accentColor,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        brightness: Brightness.dark,
        iconTheme: IconThemeData(
          color: Colors.white70,
        ),
      ),
      buttonColor: _accentColor,
      colorScheme: ColorScheme.light().copyWith(
        primary: _accentColor,
      ));
}
