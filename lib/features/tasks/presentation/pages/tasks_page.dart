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

/// Thin page — كل المنطق في TasksCubit (Zero UI Logic).
/// Why: _TasksPageBody تحت BlocProvider مباشرة عشان context.read يشتغل
/// في scroll listener (الـ State العلوي كان فوق الـ Provider → ProviderNotFound).
class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TasksCubit>(),
      child: const _TasksPageBody(),
    );
  }
}

class _TasksPageBody extends StatefulWidget {
  const _TasksPageBody();

  @override
  State<_TasksPageBody> createState() => _TasksPageBodyState();
}

class _TasksPageBodyState extends State<_TasksPageBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 300) {
      context.read<TasksCubit>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TasksCubit, TasksState>(
      listenWhen: (prev, curr) =>
          curr.failureMessage.isNotEmpty || curr.successMessage.isNotEmpty,
      listener: (context, state) {
        if (state.failureMessage.isNotEmpty) {
          AppSnackBar.show(
            context,
            message: state.failureMessage.tr(),
            isError: true,
          );
          context.read<TasksCubit>().clearFailure();
        } else {
          AppSnackBar.show(context, message: state.successMessage.tr());
          context.read<TasksCubit>().clearSuccess();
        }
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 132),
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
    );
  }
}
