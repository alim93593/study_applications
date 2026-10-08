import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/schedule_strings.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/schedule_cubit.dart';
import '../cubit/schedule_state.dart';
import 'schedule_timeline_item.dart';

/// خط اليوم الزمني + الحالات الفارغة.
class ScheduleTimeline extends StatelessWidget {
  const ScheduleTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ScheduleCubit, ScheduleState, List<ScheduleEntryView>>(
      selector: (s) => s.entries,
      builder: (context, entries) {
        if (entries.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 48,
                    color: context.colors.textHint,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    ScheduleStrings.scheduleEmpty.tr(),
                    style: AppTextStyles.bodyMutedSurface,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final entry in entries) ...[
              Text(
                entry.timeLabel,
                style: AppTextStyles.labelMedium.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              ScheduleTimelineItem(entry: entry),
              const SizedBox(height: 20),
            ],
          ],
        );
      },
    );
  }
}
