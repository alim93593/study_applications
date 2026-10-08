import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/new_task_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_section_label.dart';
import '../../domain/entities/task_entity.dart';
import '../cubit/new_task_cubit.dart';
import '../cubit/new_task_state.dart';
import 'new_task_field_style.dart';

/// حقول التاريخ ومستوى التركيز — مستخرجة من حقول النموذج (قاعدة 100 سطر).
class NewTaskScheduleFields extends StatelessWidget {
  const NewTaskScheduleFields({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NewTaskCubit, NewTaskState, (String, FocusLevel)>(
      selector: (s) => (s.dueDateDisplay, s.focusLevel),
      builder: (context, data) {
        final (dueDateDisplay, focusLevel) = data;
        final cubit = context.read<NewTaskCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSectionLabel(
              NewTaskStrings.labelDueDate.tr(),
              color: AppColors.primary,
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: cubit.onDatePickerRequested,
              child: InputDecorator(
                decoration: newTaskFieldDecoration(
                  context,
                  NewTaskStrings.hintDueDate.tr(),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 18,
                      color: context.colors.textSecondary,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      dueDateDisplay.isEmpty
                          ? NewTaskStrings.hintDueDate.tr()
                          : dueDateDisplay,
                      style: AppTextStyles.bodyStrong.copyWith(
                        color: dueDateDisplay.isEmpty
                            ? context.colors.textHint
                            : context.colors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            AppSectionLabel(
              NewTaskStrings.labelFocusLevel.tr(),
              color: AppColors.primary,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<FocusLevel>(
              initialValue: focusLevel,
              decoration: newTaskFieldDecoration(context, ''),
              items: [
                for (final level in FocusLevel.values)
                  DropdownMenuItem(
                    value: level,
                    child: Text(
                      level.labelKey.tr(),
                      style: AppTextStyles.bodyStrong.copyWith(
                        color: context.colors.textPrimary,
                      ),
                    ),
                  ),
              ],
              onChanged: (value) {
                if (value != null) {
                  cubit.onFocusChanged(value);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
