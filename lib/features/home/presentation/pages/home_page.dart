import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/widget/glass_app_bar.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primary, AppColors.primaryDark],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(child: _buildContent(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return GlassAppBar(
      title: AppStrings.appName.tr(),
      actions: [
        _buildIconButton(context, Icons.person, () {
          AppNavigator.push(AppNavigator.profile);
        }),
        const SizedBox(width: 8),
        _buildIconButton(context, Icons.logout, () {
          _showLogoutDialog(context);
        }),
      ],
    );
  }

  Widget _buildIconButton(
    BuildContext context,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.glassWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.glassBorder, width: 1),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 24),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildWelcomeCard(context),
          const SizedBox(height: 16),
          _buildStatsRow(),
          const SizedBox(height: 16),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return BlocSelector<AuthCubit, AuthState, String>(
      selector: (state) {
        if (state.status == AuthStatus.authenticated) {
          return state.user!.name.split(' ').first;
        }
        return '';
      },
      builder: (context, userName) {
        return GlassmorphicContainer(
          width: double.infinity,
          height: 120,
          borderRadius: 20,
          blur: 20,
          alignment: Alignment.center,
          border: 2,
          linearGradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.glassWhite, AppColors.glassBorder],
          ),
          borderGradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.glassBorder, AppColors.glassWhite],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.glassWhite,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.waving_hand,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppStrings.readyToLearn.tr(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.glassWhite,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(child: _buildStatCard(Icons.book, AppStrings.courses, '12')),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard(Icons.timer, AppStrings.hours, '48')),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard(Icons.star, AppStrings.points, '250')),
      ],
    );
  }

  Widget _buildStatCard(IconData icon, String title, String value) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 100,
      borderRadius: 16,
      blur: 10,
      alignment: Alignment.center,
      border: 1,
      linearGradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.glassWhite, AppColors.glassBorder],
      ),
      borderGradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.glassBorder, AppColors.glassWhite],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title.tr(),
            style: const TextStyle(fontSize: 12, color: AppColors.glassWhite),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 140,
      borderRadius: 20,
      blur: 15,
      alignment: Alignment.center,
      border: 2,
      linearGradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.glassWhite, AppColors.glassBorder],
      ),
      borderGradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.glassBorder, AppColors.glassWhite],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.quickActions.tr(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  Icons.play_circle,
                  AppStrings.continueText,
                  () {},
                ),
                _buildActionButton(Icons.quiz, AppStrings.quiz, () {}),
                _buildActionButton(
                  Icons.leaderboard,
                  AppStrings.leaderboard,
                  () {},
                ),
                _buildActionButton(
                  Icons.calendar_today,
                  AppStrings.schedule,
                  () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.glassWhite,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label.tr(),
            style: const TextStyle(fontSize: 12, color: AppColors.glassWhite),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.logout.tr()),
        content: Text(AppStrings.areYouSureLogout.tr()),
        actions: [
          TextButton(
            onPressed: () => AppNavigator.pop(),
            child: Text(AppStrings.cancel.tr()),
          ),
          TextButton(
            onPressed: () {
              AppNavigator.pop();
              context.read<AuthCubit>().signOut();
              AppNavigator.pushReplacement(AppNavigator.login);
            },
            child: Text(
              AppStrings.logout.tr(),
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
