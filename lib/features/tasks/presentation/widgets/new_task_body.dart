import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/new_task_strings.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_bottom_nav.dart';
import '../cubit/new_task_cubit.dart';
import '../cubit/new_task_state.dart';
import 'new_task_actions.dart';
import 'new_task_subjects.dart';
import 'new_task_text_fields.dart';

/// جسم شاشة المهمة: النموذج القابل للتمرير + ناف زجاجي فوقه (يتموّه المحتوى).
class NewTaskBody extends StatelessWidget {
  const NewTaskBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 132),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocSelector<NewTaskCubit, NewTaskState, bool>(
                      selector: (s) => s.isEditing,
                      builder: (context, isEditing) {
                        return Text(
                          isEditing
                              ? NewTaskStrings.taskEditTitle.tr()
                              : NewTaskStrings.newTaskTitle.tr(),
                          style: AppTextStyles.displayMedium.copyWith(
                            color: context.colors.textPrimary,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 6),
                    Text(
                      NewTaskStrings.newTaskSubtitle.tr(),
                      style: AppTextStyles.bodyMutedSurface,
                    ),
                    const SizedBox(height: 24),
                    const NewTaskSubjects(),
                    const SizedBox(height: 24),
                    const NewTaskTextFields(),
                    const SizedBox(height: 28),
                    const NewTaskActions(),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: AppBottomNav(currentIndex: 1),
        ),
      ],
    );
  }
}
