import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/home_strings.dart';
import '../../../../core/localization/stats_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'home_weekly_bar.dart';

/// مخطط أعمدة أسبوعى لتركيز آخر 7 أيام — بيانات حقيقية من الجلسات.
/// Why: بطاقة متدرجة + إجمالي الأسبوع + أعمدة متوهجة (المستخدم طلب "مدلع").
class HomeWeeklyChart extends StatelessWidget {
  const HomeWeeklyChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF1A237E), AppColors.primaryDark, AppColors.primary],
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
      child: BlocSelector<
        HomeCubit,
        HomeState,
        ({List<int> minutes, List<String> labels, int total})
      >(
        selector: (s) => (
          minutes: s.weeklyFocusMinutes,
          labels: s.weeklyDayLabels,
          total: s.weeklyTotalMinutes,
        ),
        builder: (context, data) {
          final maxMin = data.minutes.fold<int>(0, (a, b) => a > b ? a : b);
          final hours = (data.total / 60).toStringAsFixed(1);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.insights_rounded,
                    color: Colors.white.withValues(alpha: 0.85),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      HomeStrings.weeklyFocus.tr(),
                      style: AppTextStyles.labelMedium.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  // إجمالي الأسبوع — رقم كبير مدلّع.
                  Text(
                    hours,
                    style: AppTextStyles.displayLarge.copyWith(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      StatsStrings.unitHours.tr(),
                      style: AppTextStyles.captionGlass.copyWith(
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (var i = 0; i < 7; i++)
                    Expanded(
                      child: HomeWeeklyBar(
                        label: data.labels[i],
                        minutes: data.minutes[i],
                        maxMinutes: maxMin,
                        isToday: i == 6,
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
