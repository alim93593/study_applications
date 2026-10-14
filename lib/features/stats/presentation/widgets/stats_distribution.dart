import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/stats_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/stats_cubit.dart';
import '../cubit/stats_state.dart';
import 'stats_distribution_row.dart';
import 'stats_empty_card.dart';

/// توزيع الوقت على المواد — أشرطة تقدم ملوّنة (النِسب محسوبة في Cubit).
class StatsDistribution extends StatelessWidget {
  const StatsDistribution({super.key});

  static const List<Color> _palette = [
    AppColors.primary,
    AppColors.primaryLight,
    AppColors.accent,
    AppColors.info,
    AppColors.success,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      StatsCubit,
      StatsState,
      List<({String subject, String hoursDisplay, double progress})>
    >(
      selector: (s) => s.distribution,
      builder: (context, items) {
        if (items.isEmpty) {
          return StatsEmptyCard(
            message: StatsStrings.statsNoDistribution.tr(),
          );
        }
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: context.colors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.colors.softBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.pie_chart_rounded,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    StatsStrings.statsDistribution.tr(),
                    style: AppTextStyles.titleSurface.copyWith(
                      color: context.colors.textPrimary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              for (var i = 0; i < items.length; i++)
                StatsDistributionRow(
                  subject: items[i].subject,
                  hoursDisplay: items[i].hoursDisplay,
                  progress: items[i].progress,
                  color: _palette[i % _palette.length],
                ),
            ],
          ),
        );
      },
    );
  }
}
