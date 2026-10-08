import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Quick actions panel — actions are placeholders until their features land.
/// Light surface card (Focus screen redesign).
class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.softBorder),
      ),
      child: Column(
        children: [
          Text(
            AppStrings.quickActions.tr(),
            style: AppTextStyles.titleSurface.copyWith(
              color: context.colors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ActionButton(
                icon: Icons.play_circle,
                labelKey: AppStrings.continueText,
              ),
              _ActionButton(icon: Icons.quiz, labelKey: AppStrings.quiz),
              _ActionButton(
                icon: Icons.leaderboard,
                labelKey: AppStrings.leaderboard,
              ),
              _ActionButton(
                icon: Icons.calendar_today,
                labelKey: AppStrings.schedule,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.icon, required this.labelKey});

  final IconData icon;
  final String labelKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: context.colors.blueTint,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          labelKey.tr(),
          style: AppTextStyles.captionGlass.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
