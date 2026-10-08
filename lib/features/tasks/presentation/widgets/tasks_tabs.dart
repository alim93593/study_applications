import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/tasks_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/tasks_cubit.dart';
import '../cubit/tasks_state.dart';

/// تبويبا PENDING / COMPLETED — الحالة داخل الـ Cubit.
class TasksTabs extends StatelessWidget {
  const TasksTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TasksCubit, TasksState, int>(
      selector: (s) => s.selectedTab,
      builder: (context, selected) {
        return Row(
          children: [
            _Tab(
              label: TasksStrings.tasksPendingTab.tr(),
              isActive: selected == 0,
              onTap: () => context.read<TasksCubit>().selectTab(0),
            ),
            const SizedBox(width: 24),
            _Tab(
              label: TasksStrings.tasksCompletedTab.tr(),
              isActive: selected == 1,
              onTap: () => context.read<TasksCubit>().selectTab(1),
            ),
          ],
        );
      },
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _Tab({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : context.colors.textHint;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTextStyles.labelLarge.copyWith(
              color: color,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 3,
            width: 72,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ),
    );
  }
}
