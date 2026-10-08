import 'package:flutter/material.dart';

import 'app_dark_theme.dart';
import 'app_light_theme.dart';

class AppTheme {
  static ThemeData get lightTheme => buildLightTheme();

  static ThemeData get darkTheme => buildDarkTheme();
}
