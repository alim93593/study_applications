import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../localization/new_task_strings.dart';
import '../theme/app_colors.dart';

/// زر "+" الموحد أعلى الشاشات — بديل الـ FAB لإضافة مهمة/عنصر جديد.
class AppAddButton extends StatelessWidget {
  const AppAddButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.add_rounded, color: Colors.white, size: 26),
        tooltip: NewTaskStrings.newTaskTitle.tr(),
        onPressed: onPressed,
      ),
    );
  }
}
