import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';

/// بطاقة لغة واحدة (الاسم + الشارة + المعاينة + علامة الاختيار).
class LanguageCard extends StatelessWidget {
  const LanguageCard({
    super.key,
    required this.nameKey,
    required this.badgeKey,
    required this.previewKey,
    required this.isSelected,
    required this.onTap,
  });

  final String nameKey;
  final String badgeKey;
  final String previewKey;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : context.colors.softBorder,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    nameKey.tr(),
                    style: AppTextStyles.titleSmall.copyWith(
                      color: context.colors.textPrimary,
                    ),
                  ),
                ),
                Icon(
                  isSelected
                      ? Icons.check_circle_rounded
                      : Icons.circle_outlined,
                  size: 22,
                  color: isSelected
                      ? AppColors.primary
                      : context.colors.softBorder,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: context.colors.chipBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                badgeKey.tr(),
                style: AppTextStyles.captionGlass.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              previewKey.tr(),
              style: AppTextStyles.bodySurface.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
