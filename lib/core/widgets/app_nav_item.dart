import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_colors_extension.dart';
import '../theme/app_text_styles.dart';

/// عنصر تبويب واحد داخل "كبسولة" زجاجية — نفس لغة تصميم Glass بالكامل.
/// Why: المستخدم طلب تأثير زجاج حول كل أيقونة+اسم لتوحيد الـ Stampa.
class AppNavItem extends StatelessWidget {
  final IconData icon;
  final String labelKey;
  final bool isActive;
  final VoidCallback? onTap;

  const AppNavItem({
    super.key,
    required this.icon,
    required this.labelKey,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isActive ? AppColors.primary : context.colors.textHint;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          // Why: الأبيض فوق زجاج فاتح (أبيض/رمادي فاتح) شبه مخفي —
          // الفاتح يستخدم تظليل أسود خفيف والدارك أبيض، كالزجاج الحقيقي.
          color: isDark
              ? Colors.white.withValues(alpha: isActive ? 0.14 : 0.05)
              : (isActive
                    ? AppColors.primary.withValues(alpha: 0.14)
                    : Colors.black.withValues(alpha: 0.05)),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: isActive ? 0.40 : 0.12)
                : (isActive
                      ? AppColors.primary.withValues(alpha: 0.30)
                      : Colors.black.withValues(alpha: 0.08)),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 2),
            Text(
              labelKey.tr(),
              style: AppTextStyles.captionGlass.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
