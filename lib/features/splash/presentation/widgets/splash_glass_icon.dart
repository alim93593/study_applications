import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../../../core/theme/app_colors.dart';
import 'splash_shimmer.dart';

/// Glass school icon with animated glow and shimmer sweep.
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
                color: Colors.white.withValues(
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
              GlassmorphicContainer(
                width: 160,
                height: 160,
                borderRadius: 80,
                blur: 40,
                alignment: Alignment.center,
                border: 3,
                linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.3),
                    Colors.white.withValues(alpha: 0.08),
                  ],
                ),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.45),
                    Colors.white.withValues(alpha: 0.15),
                  ],
                ),
                child: const Icon(
                  Icons.school_rounded,
                  size: 80,
                  color: Colors.white,
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
