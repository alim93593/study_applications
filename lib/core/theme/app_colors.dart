import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF42617C);
  static const Color primaryLight = Color(0xFF6B8BA5);
  static const Color primaryDark = Color(0xFF2A4A63);
  static const Color primaryMid = Color(0xFF3D5A80);

  // Secondary Colors
  static const Color secondary = Color(0xFFE3E9EC);
  static const Color secondaryLight = Color(0xFFF5F7F8);
  static const Color secondaryDark = Color(0xFFC5D0D6);

  // Accent Colors
  static const Color accent = Color(0xFFFF6B6B);

  // Neutral Colors
  static const Color background = Color(
    0xFFF5F6F8,
  ); // خلفية التصاميم الجديدة (Figma)
  static const Color surface = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFFFFFFF);

  // Design Tokens (Figma screens)
  static const Color mutedCard = Color(
    0xFFEEF1F4,
  ); // البطاقات الرمادية الثانوية
  static const Color softBorder = Color(0xFFE4E8EC); // حدود/فواصل ناعمة
  static const Color chipBackground = Color(
    0xFFE9EDF1,
  ); // خلفية الشرائح غير المختارة
  static const Color blueTint = Color(0xFFD9E9F7); // بطاقة الحالة الزرقاء
  static const Color navyCard = Color(0xFF3E5C76); // البطاقات الكحلية الداكنة

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

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkFill = Color(0xFF2C2C2C);

  // Dark variants of the themed tokens (resolved via AppColorsExtension).
  static const Color darkBorder = Color(0xFF3A3F44);
  static const Color darkChipBackground = Color(0xFF333A40);
  static const Color darkBlueTint = Color(0xFF23394D);
  static const Color darkNavyCard = Color(0xFF6B8BA5);
  static const Color darkTextPrimary = Color(0xFFF5F5F5);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkTextHint = Color(0xFF757575);

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
