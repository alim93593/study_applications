import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/settings_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';

/// تذييل الإعدادات: رقم الإصدار والخصوصية والشروط (FR-032) — عرض فقط.
class SettingsFooter extends StatelessWidget {
  const SettingsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          SettingsStrings.settingsVersion.tr(),
          style: AppTextStyles.labelSurface.copyWith(
            color: context.colors.textHint,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              SettingsStrings.settingsPrivacy.tr(),
              style: AppTextStyles.labelSurface.copyWith(
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Container(width: 1, height: 12, color: context.colors.softBorder),
            const SizedBox(width: 12),
            Text(
              SettingsStrings.settingsTerms.tr(),
              style: AppTextStyles.labelSurface.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
