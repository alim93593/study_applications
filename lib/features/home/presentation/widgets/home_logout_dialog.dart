import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';

/// Confirmation dialog — fires the signOut event; navigation happens in the
/// page's BlocListener when the cubit reports unauthenticated.
Future<void> showLogoutDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(AppStrings.logout.tr()),
      content: Text(AppStrings.areYouSureLogout.tr()),
      actions: [
        TextButton(
          onPressed: AppNavigator.pop,
          child: Text(AppStrings.cancel.tr()),
        ),
        TextButton(
          onPressed: () {
            AppNavigator.pop();
            dialogContext.read<AuthCubit>().signOut();
          },
          child: Text(
            AppStrings.logout.tr(),
            style: AppTextStyles.labelMedium.copyWith(color: AppColors.error),
          ),
        ),
      ],
    ),
  );
}
