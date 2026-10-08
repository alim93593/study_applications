import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../localization/app_strings.dart';

/// Why: validation is business logic — it must not live inside any Widget
/// (Zero UI Logic rule). Shared by every Glass*Field.
abstract class AppValidators {
  AppValidators._();

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailRequired.tr();
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return AppStrings.invalidEmail.tr();
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired.tr();
    }
    if (value.length < 6) {
      return AppStrings.passwordMinLength.tr();
    }
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.nameRequired.tr();
    }
    if (value.length < 2) {
      return AppStrings.nameMinLength.tr();
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.phoneRequired.tr();
    }
    // رقم الموبايل المصري ثابت 11 رقم (010/011/012/015 + 8 أرقام).
    if (!RegExp(r'^[0-9]{11}$').hasMatch(value.trim())) {
      return AppStrings.invalidPhone.tr();
    }
    return null;
  }

  static String? Function(String?) confirmPassword(
    TextEditingController passwordController,
  ) {
    return (value) {
      if (value == null || value.isEmpty) {
        return AppStrings.confirmPasswordRequired.tr();
      }
      if (value != passwordController.text) {
        return AppStrings.passwordsDoNotMatch.tr();
      }
      return null;
    };
  }
}
