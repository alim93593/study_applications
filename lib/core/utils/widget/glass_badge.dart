import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class GlassBadge extends StatelessWidget {
  final String text;
  final GlassBadgeType type;
  final bool showDot;

  const GlassBadge({
    super.key,
    required this.text,
    this.type = GlassBadgeType.info,
    this.showDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _getBorderColor(), width: 1),
        boxShadow: [
          BoxShadow(
            color: _getBackgroundColor().withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: _getDotColor(),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _getTextColor(),
            ),
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (type) {
      case GlassBadgeType.success:
        return AppColors.success.withValues(alpha: 0.2);
      case GlassBadgeType.error:
        return AppColors.error.withValues(alpha: 0.2);
      case GlassBadgeType.warning:
        return AppColors.warning.withValues(alpha: 0.2);
      case GlassBadgeType.info:
        return AppColors.info.withValues(alpha: 0.2);
    }
  }

  Color _getBorderColor() {
    switch (type) {
      case GlassBadgeType.success:
        return AppColors.success;
      case GlassBadgeType.error:
        return AppColors.error;
      case GlassBadgeType.warning:
        return AppColors.warning;
      case GlassBadgeType.info:
        return AppColors.info;
    }
  }

  Color _getTextColor() {
    switch (type) {
      case GlassBadgeType.success:
        return AppColors.success;
      case GlassBadgeType.error:
        return AppColors.error;
      case GlassBadgeType.warning:
        return AppColors.warning;
      case GlassBadgeType.info:
        return AppColors.info;
    }
  }

  Color _getDotColor() {
    switch (type) {
      case GlassBadgeType.success:
        return AppColors.success;
      case GlassBadgeType.error:
        return AppColors.error;
      case GlassBadgeType.warning:
        return AppColors.warning;
      case GlassBadgeType.info:
        return AppColors.info;
    }
  }
}

enum GlassBadgeType { success, error, warning, info }
