import 'package:flutter/material.dart';

import 'glass_snackbar_overlay.dart';

class AppSnackBar {
  AppSnackBar._();

  static void show(
    BuildContext context, {
    required String message,
    bool isError = false,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => GlassSnackBarOverlay(
        message: message,
        isError: isError,
        duration: duration,
        onDismissed: () => entry.remove(),
      ),
    );

    overlay.insert(entry);
  }
}
