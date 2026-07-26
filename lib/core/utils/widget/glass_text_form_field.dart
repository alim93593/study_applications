import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../localization/app_strings.dart';
import '../../theme/app_colors.dart';

class GlassTextFormField extends HookWidget {
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
  final bool readOnly;
  final Function()? onTap;
  final int maxLines;
  final int? maxLength;
  final bool enabled;
  final AutovalidateMode? autovalidateMode;

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
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    final isFocused = useState(false);
    final hasError = useState(false);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.glassWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasError.value
              ? AppColors.error
              : isFocused.value
                  ? AppColors.primary
                  : AppColors.glassBorder,
          width: isFocused.value ? 2 : 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.glassShadow,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: (value) {
          final error = validator?.call(value);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            hasError.value = error != null;
          });
          return error;
        },
        onChanged: (value) {
          onChanged?.call(value);
        },
        onFieldSubmitted: (value) {
          onFieldSubmitted?.call(value);
        },
        readOnly: readOnly,
        onTap: () {
          isFocused.value = true;
          onTap?.call();
        },
        maxLines: maxLines,
        maxLength: maxLength,
        enabled: enabled,
        autovalidateMode: autovalidateMode,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hintText?.tr(),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: isFocused.value
                      ? AppColors.primary
                      : AppColors.textSecondary,
                )
              : null,
          suffixIcon: suffixIcon,
          hintStyle: TextStyle(
            color: AppColors.textHint.withValues(alpha: 0.7),
          ),
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

class GlassEmailField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const GlassEmailField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GlassTextFormField(
      controller: controller,
      labelText: AppStrings.email,
      hintText: AppStrings.email,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return AppStrings.emailRequired.tr();
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return AppStrings.invalidEmail.tr();
            }
            return null;
          },
      onChanged: onChanged,
    );
  }
}

class GlassPasswordField extends HookWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final String? labelText;

  const GlassPasswordField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    final obscureText = useState(true);

    return GlassTextFormField(
      controller: controller,
      labelText: labelText ?? AppStrings.password,
      hintText: AppStrings.password,
      prefixIcon: Icons.lock_outline,
      obscureText: obscureText.value,
      suffixIcon: IconButton(
        icon: Icon(
          obscureText.value ? Icons.visibility_off : Icons.visibility,
          color: AppColors.textSecondary,
        ),
        onPressed: () {
          obscureText.value = !obscureText.value;
        },
      ),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return AppStrings.passwordRequired.tr();
            }
            if (value.length < 6) {
              return AppStrings.passwordMinLength.tr();
            }
            return null;
          },
      onChanged: onChanged,
    );
  }
}

class GlassPhoneField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const GlassPhoneField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GlassTextFormField(
      controller: controller,
      labelText: AppStrings.phoneNumber,
      hintText: AppStrings.phoneNumber,
      prefixIcon: Icons.phone_outlined,
      keyboardType: TextInputType.phone,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return AppStrings.phoneRequired.tr();
            }
            if (!RegExp(r'^[0-9]{10,}$').hasMatch(value)) {
              return AppStrings.invalidPhone.tr();
            }
            return null;
          },
      onChanged: onChanged,
    );
  }
}

class GlassNameField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const GlassNameField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GlassTextFormField(
      controller: controller,
      labelText: AppStrings.fullName,
      hintText: AppStrings.fullName,
      prefixIcon: Icons.person_outline,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return AppStrings.nameRequired.tr();
            }
            if (value.length < 2) {
              return AppStrings.nameMinLength.tr();
            }
            return null;
          },
      onChanged: onChanged,
    );
  }
}

class GlassConfirmPasswordField extends HookWidget {
  final TextEditingController? controller;
  final TextEditingController passwordController;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const GlassConfirmPasswordField({
    super.key,
    this.controller,
    required this.passwordController,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final obscureText = useState(true);

    return GlassTextFormField(
      controller: controller,
      hintText: AppStrings.confirmPassword,
      prefixIcon: Icons.lock_outline,
      obscureText: obscureText.value,
      suffixIcon: IconButton(
        icon: Icon(
          obscureText.value ? Icons.visibility_off : Icons.visibility,
          color: AppColors.textSecondary,
        ),
        onPressed: () {
          obscureText.value = !obscureText.value;
        },
      ),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return AppStrings.confirmPasswordRequired.tr();
            }
            if (value != passwordController.text) {
              return AppStrings.passwordsDoNotMatch.tr();
            }
            return null;
          },
      onChanged: onChanged,
    );
  }
}
