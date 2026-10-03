import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/theme/app_text_styles.dart';

/// "Forgot password?" link → opens the reset flow.
class ForgotPasswordLink extends StatelessWidget {
  const ForgotPasswordLink({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppNavigator.push(AppNavigator.forgotPassword),
      child: Text(
        AppStrings.forgotPassword.tr(),
        style: AppTextStyles.labelLarge,
      ),
    );
  }
}
