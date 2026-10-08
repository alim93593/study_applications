import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/new_task_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';

/// شريحة مادة (مختارة = كحلية، غير مختارة = رمادية) كما في التصميم.
class SubjectChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const SubjectChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.navyCard
              : context.colors.chipBackground,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyStrong.copyWith(
            color: isSelected ? Colors.white : context.colors.textPrimary,
          ),
        ),
      ),
    );
  }
}

/// شريحة "+ Add New" المتقطّعة.
class SubjectAddChip extends StatelessWidget {
  final VoidCallback onTap;

  const SubjectAddChip({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: context.colors.textHint),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          NewTaskStrings.subjectAddNew.tr(),
          style: AppTextStyles.bodyStrong.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }
}
