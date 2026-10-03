import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/presentation/cubit/auth_cubit.dart';
import '../../../core/navigator/app_navigator.dart';

/// Why: side effects (animation start, status bar, delayed auth probe and the
/// final redirect) live outside the widget tree so splash_page stays
/// declarative — the widget only renders and forwards cubit events.
void startSplashEffects({
  required BuildContext context,
  required AnimationController controller,
  required AnimationController glowController,
  required AnimationController particleController,
  required AnimationController shimmerController,
}) {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  controller.forward();
  glowController.repeat(reverse: true);
  particleController.repeat();
  shimmerController.repeat();

  // Auth check starts at 6.5 seconds — after all animations are visible.
  Future.delayed(const Duration(milliseconds: 6500), () {
    if (context.mounted) context.read<AuthCubit>().checkAuthStatus();
  });
}

/// Debounced redirect: waits 2s and only navigates if the auth status has
/// not flipped again in the meantime.
void scheduleSplashRedirect({
  required BuildContext context,
  required ValueNotifier<AuthStatus?> lastStatus,
  required AuthStatus status,
}) {
  lastStatus.value = status;
  Future.delayed(const Duration(milliseconds: 2000), () {
    if (!context.mounted || lastStatus.value != status) return;
    final route = status == AuthStatus.authenticated
        ? AppNavigator.home
        : AppNavigator.login;
    AppNavigator.pushReplacement(route);
  });
}
