import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors_extension.dart';
import '../splash_animations.dart';
import '../splash_text_animations.dart';
import 'splash_background.dart';
import 'splash_icon_section.dart';
import 'splash_loading.dart';
import 'splash_subtitle.dart';
import 'splash_title_section.dart';

/// The whole splash scene (gradient scaffold + assembled sections) — extracted
/// so splash_page stays within the 100-line rule.
class SplashScene extends StatelessWidget {
  const SplashScene({
    super.key,
    required this.animations,
    required this.textAnimations,
    required this.particleController,
    required this.shimmerController,
  });

  final SplashAnimations animations;
  final SplashTextAnimations textAnimations;
  final AnimationController particleController;
  final AnimationController shimmerController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              context.colors.background,
              context.colors.mutedCard,
              context.colors.background,
            ],
          ),
        ),
        child: Stack(
          children: [
            SplashBackground(
              animations: animations,
              particleController: particleController,
            ),
            Positioned.fill(
              // fill-screen ضروري عشان الـ Column ياخد عرض الشاشة كامل
              // وإلا الـ Stack يحجزه من الشمال (alignment topStart).
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 3),
                    SplashIconSection(
                      animations: animations,
                      shimmerController: shimmerController,
                    ),
                    const SizedBox(height: 55),
                    SplashTitleSection(animations: textAnimations),
                    const SizedBox(height: 24),
                    SplashSubtitle(animations: textAnimations),
                    const Spacer(flex: 3),
                    SplashLoading(animations: textAnimations),
                    const SizedBox(height: 55),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
