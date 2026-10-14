import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/localization/new_task_strings.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/utils/snackbar/app_snackbar.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../../../../core/widgets/app_top_bar.dart';
import '../../domain/entities/task_entity.dart';
import '../cubit/new_task_cubit.dart';
import '../cubit/new_task_state.dart';
import '../widgets/new_task_body.dart';
import '../widgets/new_task_date_picker.dart';

/// شاشة "مهمة جديدة/تعديل" — الأحداث للـ Cubit والعرض النقي فقط هنا.
class NewTaskPage extends StatelessWidget {
  const NewTaskPage({super.key, this.task});

  /// غير فارغ = وضع التعديل (يعبّئ النموذج ويحوّل الحفظ إلى update).
  final TaskEntity? task;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewTaskCubit>(
      create: (_) => sl<NewTaskCubit>()..startEditing(task),
      child: BlocListener<NewTaskCubit, NewTaskState>(
        listenWhen: (prev, curr) =>
            (curr.requestDatePicker && !prev.requestDatePicker) ||
            curr.submitted ||
            (curr.failureMessage.isNotEmpty && prev.failureMessage.isEmpty),
        listener: (context, state) async {
          if (state.submitted) {
            AppNavigator.pop();
            return;
          }
          if (state.failureMessage.isNotEmpty) {
            AppSnackBar.show(
              context,
              message: state.failureMessage.tr(),
              isError: true,
            );
            context.read<NewTaskCubit>().clearFailure();
          }
          if (state.requestDatePicker) await pickTaskDate(context);
        },
        child: Scaffold(
          appBar: AppTopBar(
            title: NewTaskStrings.newTaskTitle.tr(),
            showClose: true,
          ),
          drawer: const AppDrawer(),
          body: const NewTaskBody(),
        ),
      ),
    );
  }
}
