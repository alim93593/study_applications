import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Why: status/navigation bar icons must follow the effective theme (dark
/// icons on light surfaces, light icons on dark ones). Called from
/// MaterialApp.builder so the style updates whenever ThemeMode changes.
void applySystemUiStyle(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: dark ? Brightness.light : Brightness.dark,
      statusBarBrightness: dark ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: dark
          ? Brightness.light
          : Brightness.dark,
    ),
  );
}
