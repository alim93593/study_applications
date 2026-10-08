import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/utils/snackbar/app_snackbar.dart';
import '../../../../core/widgets/app_top_bar.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/edit_profile_form.dart';

/// Thin page: screen-scoped ProfileCubit + side effects via BlocListener.
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) =>
          sl<ProfileCubit>()..seed(context.read<AuthCubit>().state.user),
      child: Scaffold(
        appBar: AppTopBar(
          title: AppStrings.editProfile.tr(),
          showBack: true,
        ),
        body: BlocListener<ProfileCubit, ProfileState>(
          listener: _onProfileChanged,
          child: const EditProfileForm(),
        ),
      ),
    );
  }

  // Navigation + snackbars only — the save logic itself lives in ProfileCubit.
  void _onProfileChanged(BuildContext context, ProfileState state) {
    final updated = state.updatedUser;
    if (state.status == ProfileStatus.saved && updated != null) {
      context.read<AuthCubit>().hydrateUser(updated);
      AppSnackBar.show(context, message: AppStrings.profileUpdated.tr());
      AppNavigator.pop();
    } else if (state.status == ProfileStatus.error) {
      AppSnackBar.show(
        context,
        message: state.errorMessage?.tr() ?? '',
        isError: true,
      );
    }
  }
}
