import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/utils/snackbar/app_snackbar.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/auth_background.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_link_row.dart';
import '../widgets/register_form.dart';

/// Thin page — StatefulWidget only for TextEditingController ownership
/// (flutter_hooks is banned project-wide).
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              message: state.errorMessage?.tr() ?? '',
              isError: true,
            );
          } else if (state.status == AuthStatus.authenticated) {
            AppNavigator.pushReplacement(AppNavigator.login);
          }
        },
        child: AuthBackground(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const AuthHeader(
                  icon: Icons.person_add,
                  titleKey: AppStrings.createAccount,
                  subtitleKey: AppStrings.signUpToGetStarted,
                ),
                const SizedBox(height: 32),
                RegisterForm(
                  formKey: _formKey,
                  nameController: _nameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
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
    );
  }
}
