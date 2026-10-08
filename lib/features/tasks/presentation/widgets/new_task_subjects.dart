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
import 'subject_chips.dart';

/// شرائح "Subject Area" + زر الإضافة الجديد كما في التصميم.
class NewTaskSubjects extends StatelessWidget {
  const NewTaskSubjects({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      NewTaskCubit,
      NewTaskState,
      (List<String>, String, bool)
    >(
      selector: (s) => (s.subjectOptions, s.subject, s.addingSubject),
      builder: (context, data) {
        final (options, selected, adding) = data;
        final cubit = context.read<NewTaskCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSectionLabel(
              NewTaskStrings.labelSubjectArea.tr(),
              color: AppColors.primary,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final subject in options)
                  SubjectChip(
                    label: subject.tr(),
                    isSelected: selected == subject,
                    onTap: () => cubit.onSubjectSelected(subject),
                  ),
                if (adding)
                  SizedBox(
                    width: 170,
                    child: TextField(
                      autofocus: true,
                      style: AppTextStyles.bodyStrong.copyWith(
                        color: context.colors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: NewTaskStrings.hintNewSubject.tr(),
                        isDense: true,
                        filled: true,
                        fillColor: context.colors.mutedCard,
                      ),
                      onSubmitted: cubit.onAddSubject,
                    ),
                  )
                else
                  SubjectAddChip(onTap: cubit.onStartAddSubject),
              ],
            ),
          ],
        );
      },
    );
  }
}
