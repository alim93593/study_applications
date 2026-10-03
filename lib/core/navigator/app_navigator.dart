import 'package:flutter/material.dart';

import '../router/app_router.dart';

class AppNavigator {
  AppNavigator._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext? get context => navigatorKey.currentContext;

  // Route constants live only in AppRouter (single source of truth);
  // these aliases keep the call sites readable without duplication.
  static const String splash = AppRouter.splash;
  static const String login = AppRouter.login;
  static const String register = AppRouter.register;
  static const String forgotPassword = AppRouter.forgotPassword;
  static const String home = AppRouter.home;
  static const String profile = AppRouter.profile;
  static const String editProfile = AppRouter.editProfile;

  static void push(String routeName, {Object? arguments}) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static void pushReplacement(String routeName, {Object? arguments}) {
    navigatorKey.currentState?.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  static void pushAndRemoveUntil(String routeName) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(routeName, (_) => false);
  }

  static void pop() {
    navigatorKey.currentState?.pop();
  }

  static void popUntil(String routeName) {
    navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
  }
}
