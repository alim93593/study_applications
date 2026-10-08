import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/stats_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/stats_cubit.dart';
import '../cubit/stats_state.dart';

/// توزيع الوقت على المواد (قائمة بنقاط ملوّنة مرتبطة بلوحة النسب).
class StatsDistribution extends StatelessWidget {
  const StatsDistribution({super.key});

  @override
  Widget build(BuildContext context) {
    // Theme-aware palette (static const can't read context).
    final palette = [
      context.colors.navyCard,
      AppColors.primaryLight,
      AppColors.secondaryDark,
      context.colors.chipBackground,
    ];
    return BlocSelector<
      StatsCubit,
      StatsState,
      List<({String subject, String hoursDisplay})>
    >(
      selector: (s) => s.distribution,
      builder: (context, items) {
        if (items.isEmpty) return const SizedBox.shrink();
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
              Text(
                StatsStrings.statsDistribution.tr(),
                style: AppTextStyles.titleLarge.copyWith(
                  color: context.colors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              for (var i = 0; i < items.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: palette[i % palette.length],
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          items[i].subject.tr(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: context.colors.textPrimary,
                          ),
                        ),
                      ),
                      Text(
                        items[i].hoursDisplay,
                        style: AppTextStyles.bodyStrong.copyWith(
                          color: context.colors.textSecondary,
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
