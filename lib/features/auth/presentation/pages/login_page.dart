import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/snackbar/app_snackbar.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_link_row.dart';
import '../widgets/forgot_password_link.dart';
import '../widgets/login_form.dart';

/// Thin page — StatefulWidget only owns the controllers (hooks are banned).
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.error) {
            AppSnackBar.show(
              context,
              message: state.errorMessage ?? '',
              isError: true,
            );
          } else if (state.status == AuthStatus.authenticated) {
            AppNavigator.pushReplacement(AppNavigator.home);
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryDark,
                AppColors.primary,
                AppColors.primaryMid,
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  const AuthHeader(
                    icon: Icons.school,
                    titleKey: AppStrings.welcomeBack,
                    subtitleKey: AppStrings.signInToContinue,
                  ),
                  const SizedBox(height: 40),
                  LoginForm(
                    formKey: _formKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  const SizedBox(height: 24),
                  const ForgotPasswordLink(),
                  const SizedBox(height: 40),
                  AuthLinkRow(
                    prefixKey: AppStrings.dontHaveAccount,
                    actionKey: AppStrings.signUp,
                    onTap: () => AppNavigator.push(AppNavigator.register),
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
