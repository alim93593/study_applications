import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/localization/new_task_strings.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/new_task_cubit.dart';
import '../cubit/new_task_state.dart';

/// أزرار الحفظ — إنشاء/مسودة، أو "حفظ التغييرات" في وضع التعديل.
class NewTaskActions extends StatelessWidget {
  const NewTaskActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NewTaskCubit, NewTaskState, (bool, bool)>(
      selector: (s) => (s.submitting, s.isEditing),
      builder: (context, values) {
        final (submitting, isEditing) = values;
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
                        isEditing
                            ? AppStrings.saveChanges.tr()
                            : NewTaskStrings.createTask.tr(),
                        style: AppTextStyles.titleMedium.copyWith(
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
            if (!isEditing) ...[
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
          ],
        );
      },
    );
  }
}
