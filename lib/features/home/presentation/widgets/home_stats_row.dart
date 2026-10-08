import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Stats row — values are placeholders until the home data layer lands.
/// Light surface cards (Focus screen redesign).
class HomeStatsRow extends StatelessWidget {
  const HomeStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.book,
            titleKey: AppStrings.courses,
            value: '12',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Icons.timer,
            titleKey: AppStrings.hours,
            value: '48',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Icons.star,
            titleKey: AppStrings.points,
            value: '250',
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.titleKey,
    required this.value,
  });

  final IconData icon;
  final String titleKey;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: context.colors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.softBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: AppColors.primary),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.titleSurface.copyWith(
              color: context.colors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            titleKey.tr(),
            style: AppTextStyles.captionGlass.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
