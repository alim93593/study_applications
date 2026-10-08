import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/presentation/cubit/auth_cubit.dart';
import '../../../core/navigator/app_navigator.dart';

/// Why: side effects (animation start, delayed auth probe and the final
/// redirect) live outside the widget tree so splash_page stays declarative.
/// The status-bar style is applied ONLY via AnnotatedRegion in splash_page
/// build — Theme.of must never run inside initState (framework crash).
/// Theme-aware system chrome for the splash.
/// Why: hardcoded dark icons were invisible on the dark splash background.
SystemUiOverlayStyle splashOverlayStyle(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness:
        isDark ? Brightness.light : Brightness.dark,
  );
}

void startSplashEffects({
  required BuildContext context,
  required AnimationController controller,
  required AnimationController glowController,
  required AnimationController particleController,
  required AnimationController shimmerController,
}) {
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
