import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_colors_extension.dart';

/// Border box for glass inputs — extracted so the base field file stays
/// within the 100-line rule.
class GlassInputContainer extends StatelessWidget {
  const GlassInputContainer({
    super.key,
    required this.isFocused,
    required this.hasError,
    this.isLightScreen = false,
    required this.child,
  });

  final bool isFocused;
  final bool hasError;

  /// why: الشاشات الداكنة (Auth) تبقي زجاجية، والشاشات الفاتحة (تعديل
  /// البروفايل) تستبدل الزجاج بـ mutedCard/softBorder عشان تكون مقروءة.
  final bool isLightScreen;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isLightScreen
            ? context.colors.mutedCard
            : AppColors.glassWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasError
              ? AppColors.error
              : isFocused
              ? AppColors.primary
              : isLightScreen
              ? context.colors.softBorder
              : AppColors.glassBorder,
          width: isFocused ? 2 : 1,
        ),
        boxShadow: isLightScreen
            ? const []
            : const [
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
