import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class GlassDivider extends StatelessWidget {
  final double height;
  final double thickness;
  final Color? color;

  const GlassDivider({
    super.key,
    this.height = 1,
    this.thickness = 1,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            (color ?? AppColors.glassBorder).withValues(alpha: 0),
            color ?? AppColors.glassBorder,
            (color ?? AppColors.glassBorder).withValues(alpha: 0),
          ],
        ),
      ),
    );
  }
}
