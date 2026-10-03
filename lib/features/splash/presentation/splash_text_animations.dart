import 'package:flutter/material.dart';

import 'splash_animations.dart';

/// Title, divider, subtitle and loading tweens of the splash intro — split
/// from SplashAnimations so both files stay under the 100-line rule.
class SplashTextAnimations {
  SplashTextAnimations({required AnimationController controller})
    : titleSlide = Tween<Offset>(begin: const Offset(0.7, 0), end: Offset.zero)
          .animate(
            CurvedAnimation(
              parent: controller,
              curve: const Interval(0.45, 0.75, curve: Curves.easeOutCubic),
            ),
          ),
      titleOpacity = splashTween(
        controller,
        0.0,
        1.0,
        0.45,
        0.7,
        curve: Curves.easeIn,
      ),
      titleLetterSpacing = splashTween(
        controller,
        18.0,
        2.0,
        0.45,
        0.8,
        curve: Curves.easeOutCubic,
      ),
      titleGlow = splashTween(
        controller,
        0.0,
        1.0,
        0.55,
        0.75,
        curve: Curves.easeInOut,
      ),
      dividerWidth = splashTween(
        controller,
        0.0,
        140.0,
        0.6,
        0.85,
        curve: Curves.easeOutCubic,
      ),
      dividerGlow = splashTween(
        controller,
        0.0,
        1.0,
        0.65,
        0.85,
        curve: Curves.easeIn,
      ),
      subtitleSlide =
          Tween<Offset>(begin: const Offset(-0.6, 0), end: Offset.zero).animate(
            CurvedAnimation(
              parent: controller,
              curve: const Interval(0.65, 0.92, curve: Curves.easeOutCubic),
            ),
          ),
      subtitleOpacity = splashTween(
        controller,
        0.0,
        1.0,
        0.65,
        0.88,
        curve: Curves.easeIn,
      ),
      loadingOpacity = splashTween(
        controller,
        0.0,
        1.0,
        0.85,
        1.0,
        curve: Curves.easeIn,
      ),
      loadingScale = splashTween(
        controller,
        0.3,
        1.0,
        0.85,
        1.0,
        curve: Curves.easeOutBack,
      );

  final Animation<Offset> titleSlide;
  final Animation<double> titleOpacity;
  final Animation<double> titleLetterSpacing;
  final Animation<double> titleGlow;
  final Animation<double> dividerWidth;
  final Animation<double> dividerGlow;
  final Animation<Offset> subtitleSlide;
  final Animation<double> subtitleOpacity;
  final Animation<double> loadingOpacity;
  final Animation<double> loadingScale;
}
