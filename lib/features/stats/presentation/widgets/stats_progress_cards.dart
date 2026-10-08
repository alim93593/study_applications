import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/stats_strings.dart';
import '../cubit/stats_cubit.dart';
import '../cubit/stats_state.dart';
import 'stats_info_card.dart';

/// بطاقتا "المهام المكتملة" و"متوسط الجلسة" كما في التصميم.
class StatsProgressCards extends StatelessWidget {
  const StatsProgressCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      StatsCubit,
      StatsState,
      (String, double, String, String, String)
    >(
      selector: (s) => (
        s.completedDisplay,
        s.weeklyGoalValue,
        s.weeklyGoalDisplay,
        s.avgSessionDisplay,
        s.consistencyDisplay,
      ),
      builder: (context, v) {
        return Column(
          children: [
            StatsInfoCard(
              icon: Icons.check_circle_outline_rounded,
              title: StatsStrings.statsCompletedTasks.tr(),
              value: v.$1,
              progress: v.$2,
              caption: '${v.$3} ${StatsStrings.statsWeeklyGoal.tr()}',
            ),
            const SizedBox(height: 16),
            StatsInfoCard(
              icon: Icons.timer_outlined,
              title: StatsStrings.statsAvgSession.tr(),
              value: v.$4,
              unit: StatsStrings.unitMin.tr(),
              caption: v.$5,
            ),
          ],
        );
      },
    );
  }
}
