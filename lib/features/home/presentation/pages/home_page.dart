import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_quick_actions.dart';
import '../widgets/home_stats_row.dart';
import '../widgets/home_welcome_card.dart';

/// Thin page — navigation happens in BlocListener when signOut succeeds.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, curr) =>
          curr.status == AuthStatus.unauthenticated &&
          prev.status == AuthStatus.loading,
      listener: (context, state) =>
          AppNavigator.pushReplacement(AppNavigator.login),
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const HomeWelcomeCard(),
                        const SizedBox(height: 16),
                        const HomeStatsRow(),
                        const SizedBox(height: 16),
                        const HomeQuickActions(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
