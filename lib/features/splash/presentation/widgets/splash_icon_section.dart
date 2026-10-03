import 'package:flutter/material.dart';

import '../splash_animations.dart';
import 'splash_glass_icon.dart';
import 'splash_ring.dart';

/// Icon cluster: fade/scale/rotation wrapper + three expanding rings.
class SplashIconSection extends StatelessWidget {
  const SplashIconSection({
    super.key,
    required this.animations,
    required this.shimmerController,
  });

  final SplashAnimations animations;
  final AnimationController shimmerController;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animations.iconOpacity,
      child: ScaleTransition(
        scale: animations.iconScale,
        child: AnimatedBuilder(
          animation: animations.iconRotation,
          builder: (context, child) {
            return Transform.rotate(
              angle: animations.iconRotation.value,
              child: child,
            );
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              SplashRing(
                opacity: animations.ring3Opacity,
                scale: animations.ring3Scale,
                alpha: 0.1,
                width: 1,
              ),
              SplashRing(
                opacity: animations.ring2Opacity,
                scale: animations.ring2Scale,
                alpha: 0.15,
                width: 1.5,
              ),
              SplashRing(
                opacity: animations.ring1Opacity,
                scale: animations.ring1Scale,
                alpha: 0.2,
                width: 2,
              ),
              SplashGlassIcon(
                glowAnimation: animations.glow,
                shimmerController: shimmerController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
