import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/localization/tasks_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/tasks_cubit.dart';
import '../cubit/tasks_state.dart';
import 'task_card.dart';

/// حذف المهمة بالسحب + حوار تأكيد — المنطق في TasksCubit (Zero UI Logic).
class TaskCardDismissible extends StatelessWidget {
  const TaskCardDismissible({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onEdit,
  });

  final TaskView task;
  final VoidCallback onToggle;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => _confirmDelete(context),
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: TaskCard(task: task, onToggle: onToggle, onEdit: onEdit),
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    final cubit = context.read<TasksCubit>();
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(TasksStrings.taskDeleteTitle.tr()),
            content: Text(TasksStrings.taskDeleteConfirm.tr()),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(AppStrings.cancel.tr()),
              ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(
                  TasksStrings.taskDelete.tr(),
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
    if (confirmed) cubit.deleteTask(task.id);
    return confirmed;
  }
}
