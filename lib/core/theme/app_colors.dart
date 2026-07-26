import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF42617C);
  static const Color primaryLight = Color(0xFF6B8BA5);
  static const Color primaryDark = Color(0xFF2A4A63);

  // Secondary Colors
  static const Color secondary = Color(0xFFE3E9EC);
  static const Color secondaryLight = Color(0xFFF5F7F8);
  static const Color secondaryDark = Color(0xFFC5D0D6);

  // Accent Colors
  static const Color accent = Color(0xFFFF6B6B);

  // Neutral Colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Glass Colors
  static const Color glassWhite = Color(0x4DFFFFFF);
  static const Color glassBorder = Color(0x80FFFFFF);
  static const Color glassShadow = Color(0x1A000000);
  static const Color glassBackground = Color(0x1AFFFFFF);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}