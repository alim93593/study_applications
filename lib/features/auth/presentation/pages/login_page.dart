import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/snackbar/app_snackbar.dart';
import '../../../../core/utils/widget/glass_button.dart';
import '../../../../core/utils/widget/glass_text_form_field.dart';
import '../cubit/auth_cubit.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryDark,
              AppColors.primary,
              Color(0xFF3D5A80),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 60),
                _buildHeader(),
                const SizedBox(height: 40),
                _buildLoginForm(
                  context,
                  formKey,
                  emailController,
                  passwordController,
                ),
                const SizedBox(height: 24),
                _buildForgotPassword(),
                const SizedBox(height: 40),
                _buildRegisterLink(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: const Icon(Icons.school, size: 40, color: Colors.white),
        ),
        const SizedBox(height: 16),
        const Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to continue',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    return BlocListener<AuthCubit, AuthState>(
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
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 320,
        borderRadius: 20,
        blur: 20,
        alignment: Alignment.center,
        border: 2,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.15),
            Colors.white.withValues(alpha: 0.05),
          ],
        ),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.3),
            Colors.white.withValues(alpha: 0.1),
          ],
        ),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                GlassEmailField(controller: emailController),
                const SizedBox(height: 16),
                GlassPasswordField(controller: passwordController),
                const SizedBox(height: 16),
                BlocSelector<AuthCubit, AuthState, bool>(
                  selector: (state) => state.status == AuthStatus.loading,
                  builder: (context, isLoading) {
                    return GlassButton(
                      text: AppStrings.signIn.tr(),
                      isLoading: isLoading,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthCubit>().signIn(
                            email: emailController.text.trim(),
                            password: passwordController.text,
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return GestureDetector(
      onTap: null,
      child: Text(
        AppStrings.forgotPassword.tr(),
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.9),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildRegisterLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.dontHaveAccount.tr(),
          style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () => AppNavigator.push(AppNavigator.register),
          child: Text(
            AppStrings.signUp.tr(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
