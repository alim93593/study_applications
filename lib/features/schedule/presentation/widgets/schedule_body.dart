import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/schedule_cubit.dart';
import '../cubit/schedule_state.dart';
import 'schedule_loading_skeleton.dart';
import 'schedule_progress_card.dart';
import 'schedule_timeline.dart';

/// محتوى الجدول: هياكل تحميل أول ما تفتح الصفحة → ثم التقدّم + الخط الزمني.
/// Why: Firestore بياخد لحظة — بدون Skeleton الصفحة تبان فاضية كأنها فارغة.
class ScheduleBody extends StatelessWidget {
  const ScheduleBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ScheduleCubit, ScheduleState, bool>(
      selector: (s) => s.isLoading,
      builder: (context, isLoading) {
        if (isLoading) return const ScheduleLoadingSkeleton();
        return const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScheduleProgressCard(),
            SizedBox(height: 20),
            ScheduleTimeline(),
          ],
        );
      },
    );
  }
}
