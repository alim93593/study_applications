import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/widget/glass_app_bar.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../widgets/profile_details.dart';

/// Thin page: selects display-ready values from AuthState and hands them to
/// ProfileDetails — no formatting happens here.
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
          onPressed: () => AppNavigator.push(AppNavigator.editProfile),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocSelector<
      AuthCubit,
      AuthState,
      (UserEntity?, String, String, String)
    >(
      selector: (state) => (
        state.user,
        state.user?.name ?? '',
        state.phoneDisplay,
        state.dobDisplay,
      ),
      builder: (context, data) {
        final (user, name, phone, dob) = data;
        if (user == null) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }
        return ProfileDetails(user: user, name: name, phone: phone, dob: dob);
      },
    );
  }
}
