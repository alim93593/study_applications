import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/settings_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/language_cubit.dart';
import '../cubit/language_state.dart';

/// التفضيلات السياقية المحفوظة (FR-035): الترجمة التلقائية وتنسيق التاريخ.
class LanguagePreferences extends StatelessWidget {
  const LanguagePreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LanguageCubit, LanguageState, (bool, bool)>(
      selector: (s) => (s.autoTranslate, s.regionalDate),
      builder: (context, values) {
        final (autoTranslate, regionalDate) = values;
        final cubit = context.read<LanguageCubit>();
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: context.colors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.colors.softBorder),
          ),
          child: Column(
            children: [
              _PreferenceRow(
                labelKey: SettingsStrings.languageAutoTranslate,
                value: autoTranslate,
                onChanged: cubit.toggleAutoTranslate,
              ),
              Divider(color: context.colors.softBorder, height: 1),
              _PreferenceRow(
                labelKey: SettingsStrings.languageRegionalDate,
                value: regionalDate,
                onChanged: cubit.toggleRegionalDate,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PreferenceRow extends StatelessWidget {
  const _PreferenceRow({
    required this.labelKey,
    required this.value,
    required this.onChanged,
  });

  final String labelKey;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            labelKey.tr(),
            style: AppTextStyles.bodySurface.copyWith(
              color: context.colors.textPrimary,
            ),
          ),
        ),
        Switch(
          value: value,
          activeThumbColor: AppColors.primary,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
