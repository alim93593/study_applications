import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/tasks_strings.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/tasks_cubit.dart';
import '../cubit/tasks_state.dart';
import 'task_card.dart';
import 'tasks_empty_state.dart';
import 'tasks_loading_skeleton.dart';

/// قوائم المهام حسب التبويب + الحالات الفارغة (من حالة الـ Cubit).
class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      TasksCubit,
      TasksState,
      (List<TaskView>, List<TaskView>, int, bool)
    >(
      selector: (s) => (s.pending, s.completed, s.selectedTab, s.isLoading),
      builder: (context, values) {
        final cubit = context.read<TasksCubit>();
        final (pending, completed, tab, isLoading) = values;
        final primary = tab == 0 ? pending : completed;

        if (isLoading) return const TasksLoadingSkeleton();
        if (primary.isEmpty) return const TasksEmptyState();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionLabel(
              tab == 0
                  ? TasksStrings.tasksUpcoming.tr()
                  : TasksStrings.tasksCompletedTab.tr(),
            ),
            const SizedBox(height: 12),
            for (final task in primary)
              TaskCard(task: task, onToggle: () => cubit.toggleComplete(task)),
            if (tab == 0 && completed.isNotEmpty) ...[
              const SizedBox(height: 20),
              _SectionLabel(TasksStrings.tasksMastered.tr()),
              const SizedBox(height: 12),
              for (final task in completed.take(3))
                TaskCard(
                  task: task,
                  onToggle: () => cubit.toggleComplete(task),
                ),
            ],
          ],
        );
      },
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.labelMedium.copyWith(
        color: context.colors.textHint,
        letterSpacing: 1.2,
      ),
    );
  }
}
