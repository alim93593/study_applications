import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_top_bar.dart';
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
      appBar: AppTopBar(title: AppStrings.profile.tr(), showBack: true),
      body: BlocSelector<
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
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          return ProfileDetails(user: user, name: name, phone: phone, dob: dob);
        },
      ),
    );
  }
}
