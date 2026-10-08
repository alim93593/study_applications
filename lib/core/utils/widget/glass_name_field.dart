import 'package:flutter/material.dart';

import '../../localization/app_strings.dart';
import '../validators/app_validators.dart';
import 'glass_text_form_field.dart';

class GlassNameField extends StatelessWidget {
  const GlassNameField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
    this.isLightScreen = false,
  });

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool isLightScreen;

  @override
  Widget build(BuildContext context) {
    return GlassTextFormField(
      controller: controller,
      labelText: AppStrings.fullName,
      hintText: AppStrings.fullName,
      prefixIcon: Icons.person_outline,
      validator: validator ?? AppValidators.name,
      onChanged: onChanged,
      isLightScreen: isLightScreen,
    );
  }
}
