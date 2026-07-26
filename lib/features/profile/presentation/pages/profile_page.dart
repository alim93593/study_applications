import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/widget/glass_app_bar.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
      title: AppStrings.profile.tr(),
      showBackButton: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.white),
          onPressed: () =>
              AppNavigator.push(AppNavigator.editProfile),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocSelector<AuthCubit, AuthState, UserEntity?>(
      selector: (state) =>
          state.status == AuthStatus.authenticated ? state.user : null,
      builder: (context, user) {
        if (user != null) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildProfilePicture(user.photoURL),
                const SizedBox(height: 16),
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.glassWhite,
                  ),
                ),
                const SizedBox(height: 24),
                _buildInfoCard(
                  Icons.person,
                  AppStrings.name,
                  user.name,
                ),
                const SizedBox(height: 12),
                _buildInfoCard(
                  Icons.email,
                  AppStrings.email,
                  user.email,
                ),
                const SizedBox(height: 12),
                _buildInfoCard(
                  Icons.phone,
                  AppStrings.phone,
                  user.phoneNumber ?? AppStrings.notProvided.tr(),
                ),
                const SizedBox(height: 12),
                _buildInfoCard(
                  Icons.cake,
                  AppStrings.dateOfBirth,
                  user.dateOfBirth != null
                      ? '${user.dateOfBirth!.day}/${user.dateOfBirth!.month}/${user.dateOfBirth!.year}'
                      : AppStrings.notProvided.tr(),
                ),
                const SizedBox(height: 24),
                _buildEditButton(context),
                const SizedBox(height: 16),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      },
    );
  }

  Widget _buildProfilePicture(String? photoURL) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.glassWhite,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.glassBorder, width: 2),
      ),
      child: photoURL != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(photoURL, fit: BoxFit.cover),
            )
          : const Icon(Icons.person, size: 60, color: Colors.white),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 80,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.glassWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.tr(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.glassWhite,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return GestureDetector(
      onTap: () => AppNavigator.push(AppNavigator.editProfile),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            AppStrings.editProfile.tr(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
