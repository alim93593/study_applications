import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Theme-aware surface/text/border tokens (light + dark variants).
/// Why: static AppColors broke dark mode — themed surfaces now resolve via
/// `context.colors.*`. Brand/status/glass tokens stay static in AppColors.
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color background;
  final Color surface;
  final Color card;
  final Color mutedCard;
  final Color softBorder;
  final Color chipBackground;
  final Color blueTint;
  final Color navyCard;
  final Color textPrimary;
  final Color textSecondary;
  final Color textHint;

  const AppColorsExtension({
    required this.background,
    required this.surface,
    required this.card,
    required this.mutedCard,
    required this.softBorder,
    required this.chipBackground,
    required this.blueTint,
    required this.navyCard,
    required this.textPrimary,
    required this.textSecondary,
    required this.textHint,
  });

  static const light = AppColorsExtension(
    background: AppColors.background,
    surface: AppColors.surface,
    card: AppColors.card,
    mutedCard: AppColors.mutedCard,
    softBorder: AppColors.softBorder,
    chipBackground: AppColors.chipBackground,
    blueTint: AppColors.blueTint,
    navyCard: AppColors.navyCard,
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.textSecondary,
    textHint: AppColors.textHint,
  );

  static const dark = AppColorsExtension(
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    card: AppColors.darkSurface,
    mutedCard: AppColors.darkFill,
    softBorder: AppColors.darkBorder,
    chipBackground: AppColors.darkChipBackground,
    blueTint: AppColors.darkBlueTint,
    navyCard: AppColors.darkNavyCard,
    textPrimary: AppColors.darkTextPrimary,
    textSecondary: AppColors.darkTextSecondary,
    textHint: AppColors.darkTextHint,
  );

  @override
  AppColorsExtension copyWith({
    Color? background,
    Color? surface,
    Color? card,
    Color? mutedCard,
    Color? softBorder,
    Color? chipBackground,
    Color? blueTint,
    Color? navyCard,
    Color? textPrimary,
    Color? textSecondary,
    Color? textHint,
  }) {
    return AppColorsExtension(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      card: card ?? this.card,
      mutedCard: mutedCard ?? this.mutedCard,
      softBorder: softBorder ?? this.softBorder,
      chipBackground: chipBackground ?? this.chipBackground,
      blueTint: blueTint ?? this.blueTint,
      navyCard: navyCard ?? this.navyCard,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textHint: textHint ?? this.textHint,
    );
  }

  @override
  AppColorsExtension lerp(
    ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      card: Color.lerp(card, other.card, t)!,
      mutedCard: Color.lerp(mutedCard, other.mutedCard, t)!,
      softBorder: Color.lerp(softBorder, other.softBorder, t)!,
      chipBackground: Color.lerp(chipBackground, other.chipBackground, t)!,
      blueTint: Color.lerp(blueTint, other.blueTint, t)!,
      navyCard: Color.lerp(navyCard, other.navyCard, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textHint: Color.lerp(textHint, other.textHint, t)!,
    );
  }
}

/// Shortcut: theme-aware palette inside any widget build method.
/// Why: falls back to the light preset when no ThemeExtension is registered
/// (widget tests, previews) instead of crashing on a null assertion.
extension AppColorsContext on BuildContext {
  AppColorsExtension get colors =>
      Theme.of(this).extension<AppColorsExtension>() ??
      AppColorsExtension.light;
}
