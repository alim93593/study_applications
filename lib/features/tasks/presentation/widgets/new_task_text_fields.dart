import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/new_task_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_section_label.dart';
import '../cubit/new_task_cubit.dart';
import 'new_task_field_style.dart';
import 'new_task_schedule_fields.dart';

/// حقول العنوان والملاحظات — StatefulWidget يملك الـ controllers (ضرورة
/// قصوى: flutter_hooks ممنوع). يُعبّأ من حالة الـ Cubit عند الدخول بوضع
/// التعديل، ويرسل الكتابة للـ Cubit عبر onChanged.
class NewTaskTextFields extends StatefulWidget {
  const NewTaskTextFields({super.key});

  @override
  State<NewTaskTextFields> createState() => _NewTaskTextFieldsState();
}

class _NewTaskTextFieldsState extends State<NewTaskTextFields> {
  late final TextEditingController _titleController;
  late final TextEditingController _notesController;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;
    final state = context.read<NewTaskCubit>().state;
    _titleController = TextEditingController(text: state.title);
    _notesController = TextEditingController(text: state.notes);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          controller: _titleController,
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
          controller: _notesController,
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
  }
}
