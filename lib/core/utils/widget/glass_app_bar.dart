import 'package:flutter/material.dart';

import '../../navigator/app_navigator.dart';
import '../../theme/app_colors.dart';

class GlassAppBar extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  const GlassAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.onBack,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          showBackButton
              ? _GlassIconButton(
                  icon: Icons.arrow_back_ios,
                  onPressed: onBack ?? () => AppNavigator.pop(),
                )
              : const SizedBox(width: 48),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions != null && actions!.isNotEmpty
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions!,
                )
              : const SizedBox(width: 48),
        ],
      ),
    );
  }
}

class _GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _GlassIconButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.glassWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.glassBorder, width: 1),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 20),
        onPressed: onPressed,
      ),
    );
  }
}
