import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';

class SplashPage extends HookWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Main timeline: 8 seconds
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 8000),
    );

    final glowController = useAnimationController(
      duration: const Duration(milliseconds: 2000),
    );

    final particleController = useAnimationController(
      duration: const Duration(milliseconds: 6000),
    );

    final shimmerController = useAnimationController(
      duration: const Duration(milliseconds: 2500),
    );

    // ==================== RADIAL BACKGROUND ====================
    final radialScale = useMemoized(
      () => Tween<double>(begin: 0.0, end: 2.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
        ),
      ),
    );

    final radialOpacity = useMemoized(
      () => Tween<double>(begin: 0.0, end: 0.12).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
        ),
      ),
    );

    // ==================== ICON ====================
    final iconScale = useMemoized(
      () => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.2, 0.55, curve: Curves.elasticOut),
        ),
      ),
    );

    final iconOpacity = useMemoized(
      () => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.2, 0.45, curve: Curves.easeIn),
        ),
      ),
    );

    final iconRotation = useMemoized(
      () => Tween<double>(begin: -0.25, end: 0.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.2, 0.55, curve: Curves.easeOutBack),
        ),
      ),
    );

    // ==================== GLOW ====================
    final glowAnimation = useMemoized(
      () => Tween<double>(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(parent: glowController, curve: Curves.easeInOut),
      ),
    );

    // ==================== RINGS ====================
    final ring1Scale = useMemoized(
      () => Tween<double>(begin: 0.6, end: 3.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.25, 0.6, curve: Curves.easeOut),
        ),
      ),
    );

    final ring1Opacity = useMemoized(
      () => Tween<double>(begin: 0.8, end: 0.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.25, 0.6, curve: Curves.easeOut),
        ),
      ),
    );

    final ring2Scale = useMemoized(
      () => Tween<double>(begin: 0.6, end: 3.8).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.35, 0.7, curve: Curves.easeOut),
        ),
      ),
    );

    final ring2Opacity = useMemoized(
      () => Tween<double>(begin: 0.5, end: 0.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.35, 0.7, curve: Curves.easeOut),
        ),
      ),
    );

    final ring3Scale = useMemoized(
      () => Tween<double>(begin: 0.6, end: 4.5).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.45, 0.8, curve: Curves.easeOut),
        ),
      ),
    );

    final ring3Opacity = useMemoized(
      () => Tween<double>(begin: 0.3, end: 0.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.45, 0.8, curve: Curves.easeOut),
        ),
      ),
    );

    // ==================== TITLE ====================
    final titleSlide = useMemoized(
      () => Tween<Offset>(
        begin: const Offset(0.7, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.45, 0.75, curve: Curves.easeOutCubic),
        ),
      ),
    );

    final titleOpacity = useMemoized(
      () => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.45, 0.7, curve: Curves.easeIn),
        ),
      ),
    );

    final titleLetterSpacing = useMemoized(
      () => Tween<double>(begin: 18.0, end: 2.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.45, 0.8, curve: Curves.easeOutCubic),
        ),
      ),
    );

    final titleGlow = useMemoized(
      () => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.55, 0.75, curve: Curves.easeInOut),
        ),
      ),
    );

    // ==================== DIVIDER ====================
    final dividerWidth = useMemoized(
      () => Tween<double>(begin: 0.0, end: 140.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.6, 0.85, curve: Curves.easeOutCubic),
        ),
      ),
    );

    final dividerGlow = useMemoized(
      () => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.65, 0.85, curve: Curves.easeIn),
        ),
      ),
    );

    // ==================== SUBTITLE ====================
    final subtitleSlide = useMemoized(
      () => Tween<Offset>(
        begin: const Offset(-0.6, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.65, 0.92, curve: Curves.easeOutCubic),
        ),
      ),
    );

    final subtitleOpacity = useMemoized(
      () => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.65, 0.88, curve: Curves.easeIn),
        ),
      ),
    );

    // ==================== LOADING ====================
    final loadingOpacity = useMemoized(
      () => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.85, 1.0, curve: Curves.easeIn),
        ),
      ),
    );

    final loadingScale = useMemoized(
      () => Tween<double>(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.85, 1.0, curve: Curves.easeOutBack),
        ),
      ),
    );

    // ==================== PARTICLES ====================
    final particleOpacity = useMemoized(
      () => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.3, 0.6, curve: Curves.easeIn),
        ),
      ),
    );

    final authResult = useState<AuthStatus?>(null);

    useEffect(() {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ));

      controller.forward();
      glowController.repeat(reverse: true);
      particleController.repeat();
      shimmerController.repeat();

      // Auth check starts at 6.5 seconds - after all animations are visible
      Future.delayed(const Duration(milliseconds: 6500), () {
        if (context.mounted) {
          context.read<AuthCubit>().checkAuthStatus();
        }
      });

      return null;
    }, []);

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, curr) {
        if (curr.status == AuthStatus.authenticated ||
            curr.status == AuthStatus.unauthenticated) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        authResult.value = state.status;
        Future.delayed(const Duration(milliseconds: 2000), () {
          if (context.mounted && authResult.value == state.status) {
            if (state.status == AuthStatus.authenticated) {
              AppNavigator.pushReplacement(AppNavigator.home);
            } else {
              AppNavigator.pushReplacement(AppNavigator.login);
            }
          }
        });
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primaryDark,
                  AppColors.primary,
                  Color(0xFF3D5A80),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Radial background glow
                AnimatedBuilder(
                  animation: radialOpacity,
                  builder: (context, child) {
                    return Center(
                      child: Transform.scale(
                        scale: radialScale.value,
                        child: Container(
                          width: 350,
                          height: 350,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Colors.white
                                    .withValues(alpha: radialOpacity.value),
                                Colors.white.withValues(alpha: 0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Particles
                FadeTransition(
                  opacity: particleOpacity,
                  child: AnimatedBuilder(
                    animation: particleController,
                    builder: (context, _) {
                      return CustomPaint(
                        size: Size(
                          MediaQuery.of(context).size.width,
                          MediaQuery.of(context).size.height,
                        ),
                        painter: _ParticlePainter(
                          progress: particleController.value,
                        ),
                      );
                    },
                  ),
                ),

                // Main content
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 3),

                      // ===== ICON =====
                      FadeTransition(
                        opacity: iconOpacity,
                        child: ScaleTransition(
                          scale: iconScale,
                          child: AnimatedBuilder(
                            animation: iconRotation,
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: iconRotation.value,
                                child: child,
                              );
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Ring 3
                                AnimatedBuilder(
                                  animation: ring3Opacity,
                                  builder: (context, child) {
                                    return Opacity(
                                      opacity: ring3Opacity.value,
                                      child: Transform.scale(
                                        scale: ring3Scale.value,
                                        child: Container(
                                          width: 170,
                                          height: 170,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white
                                                  .withValues(alpha: 0.1),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                // Ring 2
                                AnimatedBuilder(
                                  animation: ring2Opacity,
                                  builder: (context, child) {
                                    return Opacity(
                                      opacity: ring2Opacity.value,
                                      child: Transform.scale(
                                        scale: ring2Scale.value,
                                        child: Container(
                                          width: 170,
                                          height: 170,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white
                                                  .withValues(alpha: 0.15),
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                // Ring 1
                                AnimatedBuilder(
                                  animation: ring1Opacity,
                                  builder: (context, child) {
                                    return Opacity(
                                      opacity: ring1Opacity.value,
                                      child: Transform.scale(
                                        scale: ring1Scale.value,
                                        child: Container(
                                          width: 170,
                                          height: 170,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white
                                                  .withValues(alpha: 0.2),
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                // Glow + glass icon + shimmer
                                AnimatedBuilder(
                                  animation: glowAnimation,
                                  builder: (context, child) {
                                    return Container(
                                      width: 160,
                                      height: 160,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primary.withValues(
                                              alpha: glowAnimation.value * 0.6,
                                            ),
                                            blurRadius: 60 * glowAnimation.value,
                                            spreadRadius:
                                                20 * glowAnimation.value,
                                          ),
                                          BoxShadow(
                                            color: Colors.white.withValues(
                                              alpha: glowAnimation.value * 0.18,
                                            ),
                                            blurRadius:
                                                90 * glowAnimation.value,
                                            spreadRadius:
                                                35 * glowAnimation.value,
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          GlassmorphicContainer(
                                            width: 160,
                                            height: 160,
                                            borderRadius: 80,
                                            blur: 40,
                                            alignment: Alignment.center,
                                            border: 3,
                                            linearGradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Colors.white
                                                    .withValues(alpha: 0.3),
                                                Colors.white
                                                    .withValues(alpha: 0.08),
                                              ],
                                            ),
                                            borderGradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Colors.white
                                                    .withValues(alpha: 0.45),
                                                Colors.white
                                                    .withValues(alpha: 0.15),
                                              ],
                                            ),
                                            child: const Icon(
                                              Icons.school_rounded,
                                              size: 80,
                                              color: Colors.white,
                                            ),
                                          ),

                                          // Shimmer
                                          AnimatedBuilder(
                                            animation: shimmerController,
                                            builder: (context, child) {
                                              return ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(80),
                                                child: ShaderMask(
                                                  shaderCallback: (rect) {
                                                    return LinearGradient(
                                                      begin: Alignment(
                                                          -1.0 +
                                                              shimmerController
                                                                      .value *
                                                                  2.0,
                                                          0),
                                                      end: Alignment(
                                                          -0.4 +
                                                              shimmerController
                                                                      .value *
                                                                  2.0,
                                                          0),
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
                                                    color: Colors.white
                                                        .withValues(alpha: 0.1),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 55),

                      // ===== TITLE =====
                      SlideTransition(
                        position: titleSlide,
                        child: FadeTransition(
                          opacity: titleOpacity,
                          child: AnimatedBuilder(
                            animation: titleLetterSpacing,
                            builder: (context, child) {
                              return AnimatedBuilder(
                                animation: titleGlow,
                                builder: (context, child) {
                                  return Text(
                                    AppStrings.appName.tr(),
                                    style: TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: titleLetterSpacing.value,
                                      shadows: [
                                        Shadow(
                                          color: Colors.white.withValues(
                                            alpha: titleGlow.value * 0.5,
                                          ),
                                          blurRadius: 30 * titleGlow.value,
                                        ),
                                        Shadow(
                                          color: AppColors.primary.withValues(
                                            alpha: titleGlow.value * 0.4,
                                          ),
                                          blurRadius: 60 * titleGlow.value,
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

                      // ===== DIVIDER =====
                      AnimatedBuilder(
                        animation: dividerWidth,
                        builder: (context, child) {
                          return AnimatedBuilder(
                            animation: dividerGlow,
                            builder: (context, child) {
                              return Container(
                                width: dividerWidth.value,
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
                                        alpha: dividerGlow.value * 0.4,
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

                      const SizedBox(height: 24),

                      // ===== SUBTITLE =====
                      SlideTransition(
                        position: subtitleSlide,
                        child: FadeTransition(
                          opacity: subtitleOpacity,
                          child: Text(
                            AppStrings.yourLearningJourney.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white.withValues(alpha: 0.92),
                              fontWeight: FontWeight.w300,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),

                      const Spacer(flex: 3),

                      // ===== LOADING =====
                      FadeTransition(
                        opacity: loadingOpacity,
                        child: ScaleTransition(
                          scale: loadingScale,
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
                      ),

                      const SizedBox(height: 55),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final double progress;

  _ParticlePainter({required this.progress});

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

      final x =
          startX + math.sin(t * math.pi * 2 * speed) * drift;
      final y = startY -
          (t * size.height * (0.35 + random.nextDouble() * 0.65));

      final particleSize = 1.0 + random.nextDouble() * 3.5;
      final alpha = (1.0 - t) * 0.5;

      paint.color = Colors.white.withValues(alpha: alpha);
      canvas.drawCircle(Offset(x, y), particleSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
