import 'package:flutter/material.dart';

import '../../localization/app_strings.dart';
import '../../theme/app_colors.dart';
import '../validators/app_validators.dart';
import 'glass_text_form_field.dart';

/// Confirm-password input with visibility toggle — StatefulWidget owns the
/// toggle (flutter_hooks is banned project-wide).
class GlassConfirmPasswordField extends StatefulWidget {
  const GlassConfirmPasswordField({
    super.key,
    this.controller,
    required this.passwordController,
    this.validator,
    this.onChanged,
  });

  final TextEditingController? controller;
  final TextEditingController passwordController;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  @override
  State<GlassConfirmPasswordField> createState() =>
      _GlassConfirmPasswordFieldState();
}

class _GlassConfirmPasswordFieldState extends State<GlassConfirmPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return GlassTextFormField(
      controller: widget.controller,
      hintText: AppStrings.confirmPassword,
      prefixIcon: Icons.lock_outline,
      obscureText: _obscureText,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: AppColors.textSecondary,
        ),
        onPressed: () => setState(() => _obscureText = !_obscureText),
      ),
      validator:
          widget.validator ??
          AppValidators.confirmPassword(widget.passwordController),
      onChanged: widget.onChanged,
    );
  }
}
