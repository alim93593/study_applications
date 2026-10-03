import 'package:flutter/material.dart';

import '../../localization/app_strings.dart';
import '../../theme/app_colors.dart';
import '../validators/app_validators.dart';
import 'glass_text_form_field.dart';

/// Password input with visibility toggle — StatefulWidget owns the toggle
/// (flutter_hooks is banned project-wide).
class GlassPasswordField extends StatefulWidget {
  const GlassPasswordField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
    this.labelText,
  });

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final String? labelText;

  @override
  State<GlassPasswordField> createState() => _GlassPasswordFieldState();
}

class _GlassPasswordFieldState extends State<GlassPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return GlassTextFormField(
      controller: widget.controller,
      labelText: widget.labelText ?? AppStrings.password,
      hintText: AppStrings.password,
      prefixIcon: Icons.lock_outline,
      obscureText: _obscureText,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: AppColors.textSecondary,
        ),
        onPressed: () => setState(() => _obscureText = !_obscureText),
      ),
      validator: widget.validator ?? AppValidators.password,
      onChanged: widget.onChanged,
    );
  }
}
