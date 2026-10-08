import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Why: single source of truth for typography (AGENTS rule) — widgets must
/// never build a `TextStyle` by hand; use `AppTextStyles.x` and derive
/// variants with `copyWith` only.
abstract class AppTextStyles {
  AppTextStyles._();

  // ---- On-glass / white (gradient & dark backgrounds) ----
  static const displayLarge = TextStyle(
    fontSize: 42,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const displayMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const headlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const titleSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static const subtitleLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w300,
    color: Color(0xEBFFFFFF),
    letterSpacing: 1.5,
  );
  static const subtitleMedium = TextStyle(
    fontSize: 16,
    color: Color(0xCCFFFFFF),
  );
  static const bodyLarge = TextStyle(fontSize: 16, color: Colors.white);
  static const bodyGlass = TextStyle(fontSize: 16, color: AppColors.glassWhite);
  static const bodyMuted = TextStyle(fontSize: 14, color: Color(0xCCFFFFFF));
  static const bodyStrong = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  static const labelMedium = TextStyle(fontSize: 14, color: Colors.white);
  static const labelGlass = TextStyle(
    fontSize: 14,
    color: AppColors.glassWhite,
  );
  static const captionGlass = TextStyle(
    fontSize: 12,
    color: AppColors.glassWhite,
  );

  // ---- Light surfaces / banners / hints ----
  static const titleSurface = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  static const bodySurface = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  );
  static const labelSurface = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );
  static const titleNetwork = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const bodyNetwork = TextStyle(fontSize: 14, color: Colors.grey);
  static const hintGlass = TextStyle(fontSize: 14, color: Color(0xB3BDBDBD));
  static const bodyMutedSurface = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );
}
