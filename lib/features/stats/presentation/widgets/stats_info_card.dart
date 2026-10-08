import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';

/// بطاقة إحصائية واحدة (أيقونة + عنوان + رقم + اختياري شريط تقدم).
class StatsInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String? unit;
  final double? progress;
  final String caption;

  const StatsInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.unit,
    this.progress,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colors.mutedCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: AppTextStyles.bodyMutedSurface.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: AppTextStyles.displayMedium.copyWith(
                  color: context.colors.textPrimary,
                ),
              ),
              if (unit != null)
                Padding(
                  padding: const EdgeInsets.only(left: 6, bottom: 4),
                  child: Text(
                    unit!,
                    style: AppTextStyles.bodyMutedSurface.copyWith(
                      color: context.colors.textSecondary,
                    ),
                  ),
                ),
            ],
          ),
          if (progress != null) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                color: AppColors.primary,
                backgroundColor: context.colors.softBorder,
              ),
            ),
          ],
          const SizedBox(height: 8),
          Text(
            caption,
            style: AppTextStyles.captionGlass.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
