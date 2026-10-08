import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/settings_strings.dart';
import '../cubit/language_cubit.dart';
import '../cubit/language_state.dart';
import 'language_card.dart';

/// بطاقتا اختيار اللغة (English / العربية) — الاختيار في الـ Cubit والتطبيق
/// عبر زر "تطبيق اللغة" (FR-033).
class LanguageOptions extends StatelessWidget {
  const LanguageOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LanguageCubit, LanguageState, String>(
      selector: (s) => s.selectedLanguage,
      builder: (context, selected) {
        final cubit = context.read<LanguageCubit>();
        return Row(
          children: [
            Expanded(
              child: LanguageCard(
                nameKey: SettingsStrings.languageNameEn,
                badgeKey: SettingsStrings.languageDefaultLtr,
                previewKey: SettingsStrings.languagePreviewEn,
                isSelected: selected == 'en',
                onTap: () => cubit.selectLanguage('en'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: LanguageCard(
                nameKey: SettingsStrings.languageNameAr,
                badgeKey: SettingsStrings.languageClassicRtl,
                previewKey: SettingsStrings.languagePreviewAr,
                isSelected: selected == 'ar',
                onTap: () => cubit.selectLanguage('ar'),
              ),
            ),
          ],
        );
      },
    );
  }
}
