import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Border box for glass inputs — extracted so the base field file stays
/// within the 100-line rule.
class GlassInputContainer extends StatelessWidget {
  const GlassInputContainer({
    super.key,
    required this.isFocused,
    required this.hasError,
    required this.child,
  });

  final bool isFocused;
  final bool hasError;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.glassWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasError
              ? AppColors.error
              : isFocused
              ? AppColors.primary
              : AppColors.glassBorder,
          width: isFocused ? 2 : 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.glassShadow,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
