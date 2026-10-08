import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/task_entity.dart';
import '../cubit/tasks_state.dart';
import 'task_card_parts.dart';

/// بطاقة مهمة واحدة كما في تصميم Focus Matters (شريط جانبي + مربع اختيار).
class TaskCard extends StatelessWidget {
  final TaskView task;
  final VoidCallback onToggle;

  const TaskCard({super.key, required this.task, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final completed = task.status == TaskStatus.completed;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: completed ? context.colors.mutedCard : context.colors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.softBorder),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 4,
              color: completed ? AppColors.secondaryDark : AppColors.primary,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TaskCheckbox(completed: completed, onTap: onToggle),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            style: AppTextStyles.bodyStrong.copyWith(
                              color: completed
                                  ? context.colors.textHint
                                  : context.colors.textPrimary,
                              decoration: completed
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            task.meta,
                            style: AppTextStyles.captionGlass.copyWith(
                              color: task.isOverdue
                                  ? AppColors.error
                                  : context.colors.textSecondary,
                            ),
                          ),
                          if (task.isDraft) ...[
                            const SizedBox(height: 8),
                            const TaskDraftBadge(),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
