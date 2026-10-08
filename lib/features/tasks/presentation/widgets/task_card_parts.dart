import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/tasks_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';

/// مربع اختيار المهمة (دائرة) — مستخرج من بطاقة المهمة لقاعدة 100 سطر.
class TaskCheckbox extends StatelessWidget {
  final bool completed;
  final VoidCallback onTap;

  const TaskCheckbox({super.key, required this.completed, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: completed ? AppColors.secondaryDark : Colors.transparent,
          border: Border.all(
            color: completed
                ? AppColors.secondaryDark
                : context.colors.textHint,
            width: 2,
          ),
        ),
        child: completed
            ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
            : null,
      ),
    );
  }
}

/// شارة "مسودة" على البطاقة.
class TaskDraftBadge extends StatelessWidget {
  const TaskDraftBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: context.colors.chipBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        TasksStrings.taskDraft.tr(),
        style: AppTextStyles.captionGlass.copyWith(color: AppColors.primary),
      ),
    );
  }
}
