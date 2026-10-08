import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/settings_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/cubit/theme_cubit.dart';

/// اختيار الثيم (فاتح/داكن/النظام) — يُطبَّق ويُحفظ فورًا (FR-030).
class SettingsAppearance extends StatelessWidget {
  const SettingsAppearance({super.key});

  static const List<(ThemeMode, String)> _options = [
    (ThemeMode.light, SettingsStrings.themeLight),
    (ThemeMode.dark, SettingsStrings.themeDark),
    (ThemeMode.system, SettingsStrings.themeSystem),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          SettingsStrings.settingsAppearance.tr(),
          style: AppTextStyles.labelMedium.copyWith(
            color: context.colors.textSecondary,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 10),
        BlocSelector<ThemeCubit, ThemeState, ThemeMode>(
          selector: (s) => s.mode,
          builder: (context, mode) {
            final cubit = context.read<ThemeCubit>();
            return Row(
              children: [
                for (final option in _options) ...[
                  Expanded(
                    child: _ThemeChip(
                      labelKey: option.$2,
                      isSelected: mode == option.$1,
                      onTap: () => cubit.setMode(option.$1),
                    ),
                  ),
                  if (option != _options.last) const SizedBox(width: 8),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}

class _ThemeChip extends StatelessWidget {
  const _ThemeChip({
    required this.labelKey,
    required this.isSelected,
    required this.onTap,
  });

  final String labelKey;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : context.colors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : context.colors.softBorder,
          ),
        ),
        child: Text(
          labelKey.tr(),
          style: AppTextStyles.labelLarge.copyWith(
            color: isSelected ? Colors.white : context.colors.textSecondary,
          ),
        ),
      ),
    );
  }
}
