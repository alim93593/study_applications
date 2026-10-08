import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/utils/snackbar/app_snackbar.dart';
import '../cubit/forgot_password_cubit.dart';
import '../widgets/auth_background.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_link_row.dart';
import '../widgets/forgot_password_form.dart';

/// Thin page — screen-scoped ForgotPasswordCubit + side effects in listener.
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgotPasswordCubit>(
      create: (context) => sl<ForgotPasswordCubit>(),
      child: Scaffold(
        body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state.status == ForgotPasswordStatus.sent) {
              AppSnackBar.show(
                context,
                message: AppStrings.resetEmailSent.tr(),
              );
              AppNavigator.pop();
            } else if (state.status == ForgotPasswordStatus.error) {
              AppSnackBar.show(
                context,
                message: state.errorMessage?.tr() ?? '',
                isError: true,
              );
            }
          },
          child: AuthBackground(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  const AuthHeader(
                    icon: Icons.lock_reset,
                    titleKey: AppStrings.forgotPassword,
                    subtitleKey: AppStrings.resetPasswordInstructions,
                  ),
                  const SizedBox(height: 40),
                  ForgotPasswordForm(
                    formKey: _formKey,
                    emailController: _emailController,
                  ),
                  const SizedBox(height: 24),
                  AuthLinkRow(
                    prefixKey: AppStrings.alreadyHaveAccount,
                    actionKey: AppStrings.signIn,
                    onTap: AppNavigator.pop,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
