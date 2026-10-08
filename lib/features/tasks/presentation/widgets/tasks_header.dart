import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/tasks_strings.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_add_button.dart';

/// عنوان شاشة المهام (CURRICULUM PROGRESS / Focus Matters) + زر الإضافة.
class TasksHeader extends StatelessWidget {
  const TasksHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TasksStrings.tasksCurriculumProgress.tr(),
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                TasksStrings.tasksTitle.tr(),
                style: AppTextStyles.displayMedium.copyWith(
                  color: context.colors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                TasksStrings.tasksSubtitle.tr(),
                style: AppTextStyles.bodyMutedSurface,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        AppAddButton(onPressed: () => AppNavigator.push(AppRouter.newTask)),
      ],
    );
  }
}
