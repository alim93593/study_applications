import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/utils/validators/app_validators.dart';
import '../../../../core/utils/widget/glass_button.dart';
import '../../../../core/utils/widget/glass_email_field.dart';
import '../../../../core/utils/widget/glass_panel.dart';
import '../cubit/forgot_password_cubit.dart';

/// Reset-link form — validation + cubit event only, no business logic.
class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({
    super.key,
    required this.formKey,
    required this.emailController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 240,
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              GlassEmailField(
                controller: emailController,
                validator: AppValidators.email,
              ),
              const SizedBox(height: 20),
              BlocSelector<ForgotPasswordCubit, ForgotPasswordState, bool>(
                selector: (state) =>
                    state.status == ForgotPasswordStatus.loading,
                builder: (context, isLoading) {
                  return GlassButton(
                    text: AppStrings.sendResetLink.tr(),
                    isLoading: isLoading,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<ForgotPasswordCubit>().sendResetEmail(
                          emailController.text,
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
