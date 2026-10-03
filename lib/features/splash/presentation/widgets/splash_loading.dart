import 'package:flutter/material.dart';

import '../splash_text_animations.dart';

/// Closing progress indicator of the splash intro — a direct child of the
/// scene column so its layout stays bounded.
class SplashLoading extends StatelessWidget {
  const SplashLoading({super.key, required this.animations});

  final SplashTextAnimations animations;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animations.loadingOpacity,
      child: ScaleTransition(
        scale: animations.loadingScale,
        child: SizedBox(
          width: 44,
          height: 44,
          child: CircularProgressIndicator(
            color: Colors.white.withValues(alpha: 0.75),
            strokeWidth: 2.5,
            strokeCap: StrokeCap.round,
          ),
        ),
      ),
    );
  }
}
