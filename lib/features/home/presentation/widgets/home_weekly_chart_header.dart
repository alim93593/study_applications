import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/home_strings.dart';
import '../../../../core/localization/stats_strings.dart';
import '../../../../core/theme/app_text_styles.dart';

/// رأس بطاقة المخطط: أيقونة + العنوان + إجمالي الساعات الأسبوعي.
class HomeWeeklyChartHeader extends StatelessWidget {
  const HomeWeeklyChartHeader({super.key, required this.totalMinutes});

  final int totalMinutes;

  @override
  Widget build(BuildContext context) {
    final hours = (totalMinutes / 60).toStringAsFixed(1);
    return Row(
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
    );
  }
}
