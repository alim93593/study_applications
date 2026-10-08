import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/new_task_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_section_label.dart';
import '../cubit/new_task_cubit.dart';
import '../cubit/new_task_state.dart';
import 'new_task_field_style.dart';
import 'new_task_schedule_fields.dart';

/// حقول العنوان والملاحظات + تاريخ/مستوى التركيز (مستخرج لقاعدة 100 سطر).
class NewTaskTextFields extends StatelessWidget {
  const NewTaskTextFields({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NewTaskCubit, NewTaskState, String>(
      selector: (s) => s.title,
      builder: (context, title) {
        final cubit = context.read<NewTaskCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSectionLabel(
              NewTaskStrings.labelTaskTitle.tr(),
              color: AppColors.primary,
            ),
            const SizedBox(height: 10),
            TextField(
              style: AppTextStyles.bodyStrong.copyWith(
                color: context.colors.textPrimary,
              ),
              decoration: newTaskFieldDecoration(
                context,
                NewTaskStrings.hintTaskTitle.tr(),
              ),
              onChanged: cubit.onTitleChanged,
            ),
            const NewTaskScheduleFields(),
            const SizedBox(height: 20),
            AppSectionLabel(
              NewTaskStrings.labelNotes.tr(),
              color: AppColors.primary,
            ),
            const SizedBox(height: 10),
            TextField(
              maxLines: 5,
              style: AppTextStyles.bodyLarge.copyWith(
                color: context.colors.textPrimary,
              ),
              decoration: newTaskFieldDecoration(
                context,
                NewTaskStrings.hintNotes.tr(),
              ),
              onChanged: cubit.onNotesChanged,
            ),
          ],
        );
      },
    );
  }
}
