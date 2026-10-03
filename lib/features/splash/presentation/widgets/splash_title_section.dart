import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../splash_text_animations.dart';

/// Animated app title + glowing divider.
class SplashTitleSection extends StatelessWidget {
  const SplashTitleSection({super.key, required this.animations});

  final SplashTextAnimations animations;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SlideTransition(
          position: animations.titleSlide,
          child: FadeTransition(
            opacity: animations.titleOpacity,
            child: AnimatedBuilder(
              animation: animations.titleLetterSpacing,
              builder: (context, child) {
                return AnimatedBuilder(
                  animation: animations.titleGlow,
                  builder: (context, child) {
                    final glow = animations.titleGlow.value;
                    return Text(
                      AppStrings.appName.tr(),
                      style: AppTextStyles.displayLarge.copyWith(
                        letterSpacing: animations.titleLetterSpacing.value,
                        shadows: [
                          Shadow(
                            color: Colors.white.withValues(alpha: glow * 0.5),
                            blurRadius: 30 * glow,
                          ),
                          Shadow(
                            color: AppColors.primary.withValues(
                              alpha: glow * 0.4,
                            ),
                            blurRadius: 60 * glow,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        AnimatedBuilder(
          animation: animations.dividerWidth,
          builder: (context, child) {
            return AnimatedBuilder(
              animation: animations.dividerGlow,
              builder: (context, child) {
                return Container(
                  width: animations.dividerWidth.value,
                  height: 3,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.white,
                        Colors.transparent,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(
                          alpha: animations.dividerGlow.value * 0.4,
                        ),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
