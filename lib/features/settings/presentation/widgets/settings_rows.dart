import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/localization/settings_strings.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';

/// صفوف الإعدادات (FR-029/031): معلومات الشخصية، الأمان، المزامنة، اللغة.
/// الأمان والمزامنة عرض فقط (خارج نطاق البناء حسب الافتراضات).
class SettingsRows extends StatelessWidget {
  const SettingsRows({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.softBorder),
      ),
      child: Column(
        children: [
          _SettingsRow(
            icon: Icons.person_outline_rounded,
            labelKey: SettingsStrings.settingsPersonalInfo,
            onTap: () => AppNavigator.push(AppRouter.editProfile),
          ),
          Divider(color: context.colors.softBorder, height: 1),
          const _SettingsRow(
            icon: Icons.shield_outlined,
            labelKey: SettingsStrings.settingsSecurity,
          ),
          Divider(color: context.colors.softBorder, height: 1),
          const _SettingsRow(
            icon: Icons.cloud_sync_outlined,
            labelKey: SettingsStrings.settingsSync,
          ),
          Divider(color: context.colors.softBorder, height: 1),
          _SettingsRow(
            icon: Icons.translate_rounded,
            labelKey: AppStrings.language,
            onTap: () => AppNavigator.push(AppRouter.language),
          ),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({required this.icon, required this.labelKey, this.onTap});

  final IconData icon;
  final String labelKey;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: context.colors.blueTint,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                labelKey.tr(),
                style: AppTextStyles.bodySurface.copyWith(
                  color: context.colors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
