import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/tasks_strings.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';

/// الحالة الفارغة لقوائم المهام مع إجراء الإنشاء.
class TasksEmptyState extends StatelessWidget {
  const TasksEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.checklist_rounded,
              size: 48,
              color: context.colors.textHint,
            ),
            const SizedBox(height: 12),
            Text(
              TasksStrings.tasksEmpty.tr(),
              style: AppTextStyles.bodyMutedSurface,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => AppNavigator.push(AppRouter.newTask),
              child: Text(TasksStrings.tasksNew.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
