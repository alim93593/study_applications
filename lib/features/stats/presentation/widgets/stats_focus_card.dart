import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/stats_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/stats_cubit.dart';
import '../cubit/stats_state.dart';

/// بطاقة إجمالي ساعات التركيز + مخطط الأعمدة الأسبوعي.
class StatsFocusCard extends StatelessWidget {
  const StatsFocusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<StatsCubit, StatsState, (String, List<double>)>(
      selector: (s) => (s.focusHoursDisplay, s.weeklyBars),
      builder: (context, values) {
        final bars = values.$2;
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
                StatsStrings.statsTotalFocus.tr(),
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    values.$1,
                    style: AppTextStyles.displayLarge.copyWith(
                      color: context.colors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      StatsStrings.unitHours.tr(),
                      style: AppTextStyles.bodyMutedSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 72,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (var i = 0; i < 7; i++)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Container(
                            height: 12 + (i < bars.length ? bars[i] * 60 : 0),
                            decoration: BoxDecoration(
                              color: i >= 5
                                  ? context.colors.navyCard
                                  : context.colors.mutedCard,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
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
