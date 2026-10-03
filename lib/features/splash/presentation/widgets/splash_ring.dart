import 'package:flutter/material.dart';

/// One expanding ring around the splash icon.
class SplashRing extends StatelessWidget {
  const SplashRing({
    super.key,
    required this.opacity,
    required this.scale,
    required this.alpha,
    required this.width,
  });

  final Animation<double> opacity;
  final Animation<double> scale;
  final double alpha;
  final double width;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: opacity,
      builder: (context, child) {
        return Opacity(
          opacity: opacity.value,
          child: Transform.scale(
            scale: scale.value,
            child: Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: alpha),
                  width: width,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
