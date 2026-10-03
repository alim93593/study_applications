import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/utils/widget/glass_button.dart';
import '../../../../core/utils/widget/glass_email_field.dart';
import '../../../../core/utils/widget/glass_password_field.dart';
import '../../../../core/utils/widget/glass_panel.dart';
import '../cubit/auth_cubit.dart';

/// Login form panel — validation + submit event only, no business logic.
class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 320,
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
    );
  }
}
