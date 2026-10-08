import 'package:flutter/material.dart';

import '../theme/app_colors_extension.dart';
import '../theme/app_text_styles.dart';

/// لابل قسم بحروف كبيرة (نفسه في كل التصاميم الجديدة) — مشترك للشاشات كلها.
class AppSectionLabel extends StatelessWidget {
  final String text;
  final Color? color;

  const AppSectionLabel(this.text, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.labelMedium.copyWith(
        color: color ?? context.colors.textHint,
        letterSpacing: 1.2,
      ),
    );
  }
}
