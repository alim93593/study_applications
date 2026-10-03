import 'package:flutter/material.dart';

import '../../localization/app_strings.dart';
import '../validators/app_validators.dart';
import 'glass_text_form_field.dart';

class GlassPhoneField extends StatelessWidget {
  const GlassPhoneField({
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
      labelText: AppStrings.phoneNumber,
      hintText: AppStrings.phoneNumber,
      prefixIcon: Icons.phone_outlined,
      keyboardType: TextInputType.phone,
      validator: validator ?? AppValidators.phone,
      onChanged: onChanged,
    );
  }
}
