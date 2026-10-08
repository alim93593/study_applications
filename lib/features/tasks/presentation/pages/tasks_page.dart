import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/snackbar/app_snackbar.dart';
import '../cubit/tasks_cubit.dart';
import '../cubit/tasks_state.dart';
import '../widgets/tasks_banner.dart';
import '../widgets/tasks_header.dart';
import '../widgets/tasks_insight_card.dart';
import '../widgets/tasks_list.dart';
import '../widgets/tasks_tabs.dart';

/// Thin page — كل المنطق والنصوص المحسوبة داخل TasksCubit (Zero UI Logic).
class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TasksCubit>(),
      child: BlocListener<TasksCubit, TasksState>(
        listenWhen: (prev, curr) => curr.failureMessage.isNotEmpty,
        listener: (context, state) {
          AppSnackBar.show(
            context,
            message: state.failureMessage.tr(),
            isError: true,
          );
          context.read<TasksCubit>().clearFailure();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TasksHeader(),
              SizedBox(height: 16),
              TasksInsightCard(),
              SizedBox(height: 16),
              TasksBanner(),
              SizedBox(height: 16),
              TasksTabs(),
              SizedBox(height: 16),
              TasksList(),
            ],
          ),
        ),
      ),
    );
  }
}
