import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import 'splash_shimmer.dart';

/// School icon on a light surface circle with animated glow and shimmer sweep.
class SplashGlassIcon extends StatelessWidget {
  const SplashGlassIcon({
    super.key,
    required this.glowAnimation,
    required this.shimmerController,
  });

  final Animation<double> glowAnimation;
  final AnimationController shimmerController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glowAnimation,
      builder: (context, child) {
        return Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(
                  alpha: glowAnimation.value * 0.6,
                ),
                blurRadius: 60 * glowAnimation.value,
                spreadRadius: 20 * glowAnimation.value,
              ),
              BoxShadow(
                color: AppColors.primary.withValues(
                  alpha: glowAnimation.value * 0.18,
                ),
                blurRadius: 90 * glowAnimation.value,
                spreadRadius: 35 * glowAnimation.value,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.card,
                  border: Border.all(
                    color: context.colors.softBorder,
                    width: 3,
                  ),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  size: 80,
                  color: AppColors.primary,
                ),
              ),
              SplashShimmer(shimmerController: shimmerController),
            ],
          ),
        );
      },
    );
  }
}
