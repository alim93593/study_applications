import 'package:flutter/material.dart';

import 'glass_snackbar_content.dart';

/// Overlay entry + animation lifecycle for the glass snackbar.
/// Why split from app_snackbar.dart: keeps every file under the 100-line rule.
class GlassSnackBarOverlay extends StatefulWidget {
  final String message;
  final bool isError;
  final Duration duration;
  final VoidCallback onDismissed;

  const GlassSnackBarOverlay({
    super.key,
    required this.message,
    required this.isError,
    required this.duration,
    required this.onDismissed,
  });

  @override
  State<GlassSnackBarOverlay> createState() => _GlassSnackBarOverlayState();
}

class _GlassSnackBarOverlayState extends State<GlassSnackBarOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();

    Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse().then((_) => widget.onDismissed());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Positioned(
      top: statusBarHeight + 8,
      left: 16,
      right: 16,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: GlassSnackBarContent(
            message: widget.message,
            isError: widget.isError,
            onClose: () {
              _controller.reverse().then((_) => widget.onDismissed());
            },
          ),
        ),
      ),
    );
  }
}
