import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../splash_animations.dart';
import '../splash_effects.dart';
import '../splash_text_animations.dart';
import '../widgets/splash_redirect.dart';
import '../widgets/splash_scene.dart';

/// Thin page — StatefulWidget + TickerProviderStateMixin own the four
/// animation controllers (flutter_hooks is banned project-wide).
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _glowController;
  late final AnimationController _particleController;
  late final AnimationController _shimmerController;
  late final SplashAnimations _animations;
  late final SplashTextAnimations _textAnimations;
  final ValueNotifier<AuthStatus?> _lastStatus = ValueNotifier<AuthStatus?>(
    null,
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 8000),
    );
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6000),
    );
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _animations = SplashAnimations(
      controller: _controller,
      glowController: _glowController,
    );
    _textAnimations = SplashTextAnimations(controller: _controller);
    startSplashEffects(
      context: context,
      controller: _controller,
      glowController: _glowController,
      particleController: _particleController,
      shimmerController: _shimmerController,
    );
  }

  @override
  void dispose() {
    _lastStatus.dispose();
    _controller.dispose();
    _glowController.dispose();
    _particleController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SplashRedirect(
      lastStatus: _lastStatus,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: splashOverlayStyle(context),
        child: SplashScene(
          animations: _animations,
          textAnimations: _textAnimations,
          particleController: _particleController,
          shimmerController: _shimmerController,
        ),
      ),
    );
  }
}
