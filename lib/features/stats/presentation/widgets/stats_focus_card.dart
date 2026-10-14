import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/stats_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/stats_cubit.dart';
import '../cubit/stats_state.dart';
import 'stats_weekly_bars.dart';

/// بطاقة إجمالي ساعات التركيز + مخطط الأعمدة الأسبوعي.
/// Why: خلفية متدرجة (primary→primaryDark) عشان تبان حية في الاتنين الثيمين.
class StatsFocusCard extends StatelessWidget {
  const StatsFocusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<StatsCubit, StatsState, (String, List<double>, List<String>)>(
      selector: (s) => (s.focusHoursDisplay, s.weeklyBars, s.weeklyBarLabels),
      builder: (context, values) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primaryDark, AppColors.primary],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.bar_chart_rounded, color: Colors.white.withValues(alpha: 0.8), size: 20),
                  const SizedBox(width: 8),
                  Text(
                    StatsStrings.statsTotalFocus.tr(),
                    style: AppTextStyles.labelMedium.copyWith(
                      color: Colors.white.withValues(alpha: 0.85),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    values.$1,
                    style: AppTextStyles.displayLarge.copyWith(
                      color: Colors.white,
                      fontSize: 48,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      StatsStrings.unitHours.tr(),
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              StatsWeeklyBars(bars: values.$2, labels: values.$3),
            ],
          ),
        );
      },
    );
  }
}
