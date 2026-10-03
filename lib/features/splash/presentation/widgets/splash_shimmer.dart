import 'package:flutter/material.dart';

/// Shimmer sweep that runs across the glass icon.
class SplashShimmer extends StatelessWidget {
  const SplashShimmer({super.key, required this.shimmerController});

  final AnimationController shimmerController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shimmerController,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(80),
          child: ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment(-1.0 + shimmerController.value * 2.0, 0),
                end: Alignment(-0.4 + shimmerController.value * 2.0, 0),
                colors: const [
                  Colors.transparent,
                  Colors.white,
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 1.0],
              ).createShader(rect);
            },
            child: Container(
              width: 160,
              height: 160,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
        );
      },
    );
  }
}
