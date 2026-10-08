import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../cubit/schedule_cubit.dart';
import '../widgets/schedule_header.dart';
import '../widgets/schedule_progress_card.dart';
import '../widgets/schedule_timeline.dart';

/// شاشة "الجدول اليومي" (Daily Rhythm) — thin page داخل الـ Shell.
class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ScheduleCubit>(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            ScheduleHeader(),
            SizedBox(height: 16),
            ScheduleProgressCard(),
            SizedBox(height: 20),
            ScheduleTimeline(),
          ],
        ),
      ),
    );
  }
}
