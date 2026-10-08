import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors_extension.dart';

/// زخرفة حقول نموذج المهمة الجديدة (موحّدة بين الحقول).
InputDecoration newTaskFieldDecoration(BuildContext context, String hint) {
  return InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: context.colors.mutedCard,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  );
}
