import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Rising light particles behind the splash content.
class SplashParticlePainter extends CustomPainter {
  SplashParticlePainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final random = math.Random(42);

    for (int i = 0; i < 35; i++) {
      final startX = random.nextDouble() * size.width;
      final startY = size.height + 30;
      final speed = 0.15 + random.nextDouble() * 0.85;
      final delay = random.nextDouble() * 0.65;
      final drift = (random.nextDouble() - 0.5) * 100;

      final t = (progress - delay).clamp(0.0, 1.0);
      if (t <= 0) continue;

      final x = startX + math.sin(t * math.pi * 2 * speed) * drift;
      final y =
          startY - (t * size.height * (0.35 + random.nextDouble() * 0.65));

      final particleSize = 1.0 + random.nextDouble() * 3.5;
      final alpha = (1.0 - t) * 0.5;

      paint.color = Colors.white.withValues(alpha: alpha);
      canvas.drawCircle(Offset(x, y), particleSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant SplashParticlePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
