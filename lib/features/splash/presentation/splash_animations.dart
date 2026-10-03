import 'package:flutter/material.dart';

/// begin/end tween running between start%..finish% of the master timeline.
Animation<double> splashTween(
  AnimationController controller,
  double begin,
  double end,
  double start,
  double finish, {
  Curve curve = Curves.easeOut,
}) => Tween<double>(begin: begin, end: end).animate(
  CurvedAnimation(
    parent: controller,
    curve: Interval(start, finish, curve: curve),
  ),
);

/// Plain curve tween (no timeline interval) — used by the looping glow.
Animation<double> splashCurve(
  AnimationController controller,
  double begin,
  double end,
  Curve curve,
) => Tween<double>(
  begin: begin,
  end: end,
).animate(CurvedAnimation(parent: controller, curve: curve));

/// Core splash tweens: background radial, icon entrance, rings and glow.
/// Text-section tweens live in SplashTextAnimations (100-line rule).
class SplashAnimations {
  SplashAnimations({
    required AnimationController controller,
    required AnimationController glowController,
  }) : radialScale = splashTween(controller, 0.0, 2.0, 0.0, 0.4),
       radialOpacity = splashTween(
         controller,
         0.0,
         0.12,
         0.0,
         0.3,
         curve: Curves.easeIn,
       ),
       iconScale = splashTween(
         controller,
         0.0,
         1.0,
         0.2,
         0.55,
         curve: Curves.elasticOut,
       ),
       iconOpacity = splashTween(
         controller,
         0.0,
         1.0,
         0.2,
         0.45,
         curve: Curves.easeIn,
       ),
       iconRotation = splashTween(
         controller,
         -0.25,
         0.0,
         0.2,
         0.55,
         curve: Curves.easeOutBack,
       ),
       glow = splashCurve(glowController, 0.3, 1.0, Curves.easeInOut),
       ring1Scale = splashTween(controller, 0.6, 3.0, 0.25, 0.6),
       ring1Opacity = splashTween(controller, 0.8, 0.0, 0.25, 0.6),
       ring2Scale = splashTween(controller, 0.6, 3.8, 0.35, 0.7),
       ring2Opacity = splashTween(controller, 0.5, 0.0, 0.35, 0.7),
       ring3Scale = splashTween(controller, 0.6, 4.5, 0.45, 0.8),
       ring3Opacity = splashTween(controller, 0.3, 0.0, 0.45, 0.8),
       particleOpacity = splashTween(
         controller,
         0.0,
         1.0,
         0.3,
         0.6,
         curve: Curves.easeIn,
       );

  final Animation<double> radialScale;
  final Animation<double> radialOpacity;
  final Animation<double> iconScale;
  final Animation<double> iconOpacity;
  final Animation<double> iconRotation;
  final Animation<double> glow;
  final Animation<double> ring1Scale;
  final Animation<double> ring1Opacity;
  final Animation<double> ring2Scale;
  final Animation<double> ring2Opacity;
  final Animation<double> ring3Scale;
  final Animation<double> ring3Opacity;
  final Animation<double> particleOpacity;
}
