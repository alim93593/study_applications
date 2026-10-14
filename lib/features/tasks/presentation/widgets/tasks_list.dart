import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/tasks_strings.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/tasks_cubit.dart';
import '../cubit/tasks_state.dart';
import 'task_card_dismissible.dart';
import 'tasks_empty_state.dart';
import 'tasks_loading_skeleton.dart';

/// قوائم المهام حسب التبويب + الحالات الفارغة (من حالة الـ Cubit).
/// الضغط على البطاقة → تعديل؛ السحب لليسار → حذف بتأكيد.
/// مؤشر تحميل في الآخر أثناء الباجبنيشن (loadMore).
class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      TasksCubit,
      TasksState,
      (List<TaskView>, List<TaskView>, int, bool, bool, bool)
    >(
      selector: (s) => (
        s.pending,
        s.completed,
        s.selectedTab,
        s.isLoading,
        s.hasMore,
        s.isLoadingMore,
      ),
      builder: (context, values) {
        final cubit = context.read<TasksCubit>();
        final (pending, completed, tab, isLoading, hasMore, isLoadingMore) =
            values;
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
              TaskCardDismissible(
                task: task,
                onToggle: () => cubit.toggleComplete(task),
                onEdit: () => AppNavigator.push(
                  AppRouter.newTask,
                  arguments: task.entity,
                ),
              ),
            if (tab == 0 && completed.isNotEmpty) ...[
              const SizedBox(height: 20),
              _SectionLabel(TasksStrings.tasksMastered.tr()),
              const SizedBox(height: 12),
              for (final task in completed.take(3))
                TaskCardDismissible(
                  task: task,
                  onToggle: () => cubit.toggleComplete(task),
                  onEdit: () => AppNavigator.push(
                    AppRouter.newTask,
                    arguments: task.entity,
                  ),
                ),
            ],
            // مؤشر تحميل الدفعة التالية.
            if (isLoadingMore)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: CircularProgressIndicator()),
              ),
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
