import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Keeps status/navigation bar icons light while the covered screen has a
/// dark surface (auth & profile) — overrides the theme-driven global style
/// applied in MaterialApp.builder.
class DarkScreenOverlay extends StatelessWidget {
  const DarkScreenOverlay({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: child,
    );
  }
}
