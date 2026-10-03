import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../splash_text_animations.dart';

/// Animated splash subtitle — sits directly in the scene column (no nested
/// flex, otherwise it would receive unbounded height).
class SplashSubtitle extends StatelessWidget {
  const SplashSubtitle({super.key, required this.animations});

  final SplashTextAnimations animations;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animations.subtitleSlide,
      child: FadeTransition(
        opacity: animations.subtitleOpacity,
        child: Text(
          AppStrings.yourLearningJourney.tr(),
          textAlign: TextAlign.center,
          style: AppTextStyles.subtitleLarge,
        ),
      ),
    );
  }
}
