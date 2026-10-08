import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/tasks_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/tasks_cubit.dart';
import '../cubit/tasks_state.dart';

/// نظرة عامة (Active Research / Archived Notes) — القيم تأتي من الـ Cubit.
class TasksInsightCard extends StatelessWidget {
  const TasksInsightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TasksCubit, TasksState, (String, String, double)>(
      selector: (s) => (s.activeDisplay, s.archivedDisplay, s.insightProgress),
      builder: (context, values) {
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
                TasksStrings.tasksInsightOverview.tr(),
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              _Row(label: TasksStrings.tasksActiveResearch.tr(), value: values.$1),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: values.$3,
                  minHeight: 6,
                  color: AppColors.primary,
                  backgroundColor: context.colors.mutedCard,
                ),
              ),
              const SizedBox(height: 16),
              _Row(label: TasksStrings.tasksArchivedNotes.tr(), value: values.$2),
            ],
          ),
        );
      },
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;

  const _Row({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodyMutedSurface),
        Text(
          value,
          style: AppTextStyles.titleLarge.copyWith(color: AppColors.primary),
        ),
      ],
    );
  }
}
