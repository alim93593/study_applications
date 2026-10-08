import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/localization/new_task_strings.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/snackbar/app_snackbar.dart';
import '../../../../core/widgets/app_bottom_nav.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../../../../core/widgets/app_top_bar.dart';
import '../cubit/new_task_cubit.dart';
import '../cubit/new_task_state.dart';
import '../widgets/new_task_actions.dart';
import '../widgets/new_task_date_picker.dart';
import '../widgets/new_task_subjects.dart';
import '../widgets/new_task_text_fields.dart';

/// شاشة "مهمة جديدة" — الأحداث للـ Cubit والعرض النقي فقط هنا.
class NewTaskPage extends StatelessWidget {
  const NewTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NewTaskCubit>(),
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
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        NewTaskStrings.newTaskTitle.tr(),
                        style: AppTextStyles.displayMedium.copyWith(
                          color: context.colors.textPrimary,
                        ),
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
              const AppBottomNav(currentIndex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
