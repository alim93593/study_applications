import 'package:flutter/material.dart';

import '../../localization/app_strings.dart';
import '../validators/app_validators.dart';
import 'glass_text_form_field.dart';

class GlassEmailField extends StatelessWidget {
  const GlassEmailField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return GlassTextFormField(
      controller: controller,
      labelText: AppStrings.email,
      hintText: AppStrings.email,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator: validator ?? AppValidators.email,
      onChanged: onChanged,
    );
  }
}
