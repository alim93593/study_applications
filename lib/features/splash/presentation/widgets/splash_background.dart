import 'package:flutter/material.dart';

import '../splash_animations.dart';
import 'splash_particle_painter.dart';

/// Radial glow + rising particles behind the splash content.
class SplashBackground extends StatelessWidget {
  const SplashBackground({
    super.key,
    required this.animations,
    required this.particleController,
  });

  final SplashAnimations animations;
  final AnimationController particleController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: animations.radialOpacity,
          builder: (context, child) {
            return Center(
              child: Transform.scale(
                scale: animations.radialScale.value,
                child: Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withValues(
                          alpha: animations.radialOpacity.value,
                        ),
                        Colors.white.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        FadeTransition(
          opacity: animations.particleOpacity,
          child: AnimatedBuilder(
            animation: particleController,
            builder: (context, _) {
              return CustomPaint(
                size: Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height,
                ),
                painter: SplashParticlePainter(
                  progress: particleController.value,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
