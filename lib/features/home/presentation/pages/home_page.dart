import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/utils/snackbar/app_snackbar.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../cubit/focus_session_cubit.dart';
import '../cubit/focus_session_state.dart';
import '../cubit/home_cubit.dart';
import '../widgets/focus_session_card.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_stats_row.dart';
import '../widgets/home_welcome_card.dart';
import '../widgets/home_weekly_chart.dart';

/// Thin page — navigation happens in BlocListener when signOut succeeds.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => GetIt.instance<HomeCubit>(),
      child: BlocProvider<FocusSessionCubit>(
        create: (_) => GetIt.instance<FocusSessionCubit>(),
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthCubit, AuthState>(
              listenWhen: (prev, curr) =>
                  curr.status == AuthStatus.unauthenticated &&
                  prev.status == AuthStatus.loading,
              listener: (context, state) =>
                  AppNavigator.pushReplacement(AppNavigator.login),
            ),
            BlocListener<FocusSessionCubit, FocusSessionState>(
              listenWhen: (prev, curr) => curr.failureMessage.isNotEmpty,
              listener: (context, state) {
                AppSnackBar.show(
                  context,
                  message: state.failureMessage.tr(),
                  isError: true,
                );
                context.read<FocusSessionCubit>().clearFailure();
              },
            ),
          ],
          child: Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: context.colors.background,
              child: SafeArea(
                child: Column(
                  children: [
                    const HomeAppBar(),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 132),
                        child: Column(
                          children: [
                            const HomeWelcomeCard(),
                            const SizedBox(height: 16),
                            const HomeStatsRow(),
                            const SizedBox(height: 16),
                            const FocusSessionCard(),
                            const SizedBox(height: 16),
                            const HomeWeeklyChart(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
