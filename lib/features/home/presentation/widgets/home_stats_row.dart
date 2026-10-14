import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/home_strings.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'home_stat_card.dart';

/// بطاقات إحصائيات الفوكس — قيم حقيقية من HomeCubit (صفر قيم وهمية).
class HomeStatsRow extends StatelessWidget {
  const HomeStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      HomeCubit,
      HomeState,
      ({String tasks, String focus, String completion})
    >(
      selector: (s) => (
        tasks: s.todayTasksDisplay,
        focus: s.focusHoursDisplay,
        completion: s.completionDisplay,
      ),
      builder: (context, data) {
        return Row(
          children: [
            Expanded(
              child: HomeStatCard(
                icon: Icons.today,
                titleKey: HomeStrings.todayTasks,
                value: data.tasks,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: HomeStatCard(
                icon: Icons.timer,
                titleKey: HomeStrings.focusToday,
                value: data.focus,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: HomeStatCard(
                icon: Icons.check_circle,
                titleKey: HomeStrings.completion,
                value: data.completion,
              ),
            ),
          ],
        );
      },
    );
  }
}
