import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/new_task_strings.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/new_task_cubit.dart';
import '../cubit/new_task_state.dart';

/// أزرار "Create Task" و "Save as Draft".
class NewTaskActions extends StatelessWidget {
  const NewTaskActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NewTaskCubit, NewTaskState, bool>(
      selector: (s) => s.submitting,
      builder: (context, submitting) {
        final cubit = context.read<NewTaskCubit>();
        return Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: context.colors.navyCard,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: submitting ? null : cubit.submitAsTask,
                child: submitting
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        NewTaskStrings.createTask.tr(),
                        style: AppTextStyles.titleMedium.copyWith(
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: submitting ? null : cubit.submitAsDraft,
              child: Text(
                NewTaskStrings.saveAsDraft.tr(),
                style: AppTextStyles.bodyStrong.copyWith(
                  color: context.colors.textPrimary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
