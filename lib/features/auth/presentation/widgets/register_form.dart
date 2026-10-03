import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/utils/widget/glass_button.dart';
import '../../../../core/utils/widget/glass_confirm_password_field.dart';
import '../../../../core/utils/widget/glass_email_field.dart';
import '../../../../core/utils/widget/glass_name_field.dart';
import '../../../../core/utils/widget/glass_panel.dart';
import '../../../../core/utils/widget/glass_password_field.dart';
import '../cubit/auth_cubit.dart';

/// Register form panel — validation + submit event only, no business logic.
class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 480,
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              GlassNameField(controller: nameController),
              const SizedBox(height: 16),
              GlassEmailField(controller: emailController),
              const SizedBox(height: 16),
              GlassPasswordField(
                controller: passwordController,
                labelText: AppStrings.password,
              ),
              const SizedBox(height: 16),
              GlassConfirmPasswordField(
                controller: confirmPasswordController,
                passwordController: passwordController,
              ),
              const SizedBox(height: 20),
              BlocSelector<AuthCubit, AuthState, bool>(
                selector: (state) => state.status == AuthStatus.loading,
                builder: (context, isLoading) {
                  return GlassButton(
                    text: AppStrings.signUp.tr(),
                    isLoading: isLoading,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthCubit>().signUp(
                          email: emailController.text.trim(),
                          password: passwordController.text,
                          name: nameController.text.trim(),
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
    );
  }
}
