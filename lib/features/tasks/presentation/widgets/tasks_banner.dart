import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/tasks_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';

/// بانر "Stay Disciplined" — تدرّج كحلي بدل صورة (أصول الصورة تُضاف لاحقًا
/// في AppAssets حسب التصميم).
class TasksBanner extends StatelessWidget {
  const TasksBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [context.colors.navyCard, AppColors.primaryDark],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.menu_book_rounded,
            size: 56,
            color: Colors.white.withValues(alpha: 0.25),
          ),
          Text(
            TasksStrings.tasksBanner.tr(),
            style: AppTextStyles.titleLarge.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
