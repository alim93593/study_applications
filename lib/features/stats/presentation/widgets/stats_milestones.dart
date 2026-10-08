import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/stats_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/stats_cubit.dart';
import '../cubit/stats_state.dart';

/// إنجازات التعلّم المكتسبة (المكافآت تظهر فقط عند تحقيقها من البيانات).
class StatsMilestones extends StatelessWidget {
  const StatsMilestones({super.key});

  static const List<IconData> _icons = [
    Icons.menu_book_rounded,
    Icons.bolt_rounded,
    Icons.emoji_events_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocSelector<StatsCubit, StatsState, List<MilestoneView>>(
      selector: (s) => s.milestones,
      builder: (context, milestones) {
        if (milestones.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StatsStrings.statsMilestones.tr(),
              style: AppTextStyles.titleLarge.copyWith(
                color: context.colors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            for (var i = 0; i < milestones.length; i++)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.colors.mutedCard,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: context.colors.chipBackground,
                      child: Icon(
                        _icons[i % _icons.length],
                        size: 18,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            milestones[i].title,
                            style: AppTextStyles.bodyStrong.copyWith(
                              color: context.colors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            milestones[i].description,
                            style: AppTextStyles.bodyMutedSurface,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
