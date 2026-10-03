import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import 'glass_input_container.dart';

/// Base glass input — StatefulWidget is the necessary exception (it owns the
/// focus/error visual state); flutter_hooks is banned project-wide.
class GlassTextFormField extends StatefulWidget {
  const GlassTextFormField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;

  @override
  State<GlassTextFormField> createState() => _GlassTextFormFieldState();
}

class _GlassTextFormFieldState extends State<GlassTextFormField> {
  bool _isFocused = false;
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return GlassInputContainer(
      isFocused: _isFocused,
      hasError: _hasError,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        validator: (value) {
          final error = widget.validator?.call(value);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() => _hasError = error != null);
          });
          return error;
        },
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        onTap: () => setState(() => _isFocused = true),
        style: AppTextStyles.bodySurface,
        decoration: InputDecoration(
          hintText: widget.hintText?.tr(),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  color: _isFocused
                      ? AppColors.primary
                      : AppColors.textSecondary,
                )
              : null,
          suffixIcon: widget.suffixIcon,
          hintStyle: AppTextStyles.hintGlass,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
