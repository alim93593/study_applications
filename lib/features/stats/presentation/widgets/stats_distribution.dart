import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/stats_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/subject_label.dart';
import '../cubit/stats_cubit.dart';
import '../cubit/stats_state.dart';
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
                  Icon(Icons.pie_chart_rounded, size: 20, color: AppColors.primary),
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: _palette[i % _palette.length],
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              items[i].subject.subjectLabel,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodyLarge.copyWith(
                                color: context.colors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            items[i].hoursDisplay,
                            style: AppTextStyles.bodyStrong.copyWith(
                              color: _palette[i % _palette.length],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: items[i].progress,
                          minHeight: 6,
                          color: _palette[i % _palette.length],
                          backgroundColor: context.colors.mutedCard,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
