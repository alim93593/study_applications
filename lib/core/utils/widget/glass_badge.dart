import 'package:flutter/material.dart';

import '../../theme/app_text_styles.dart';
import 'glass_badge_type.dart';

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
        color: type.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: type.color, width: 1),
        boxShadow: [
          BoxShadow(
            color: type.background.withValues(alpha: 0.3),
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
                color: type.color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: AppTextStyles.captionGlass.copyWith(
              fontWeight: FontWeight.w600,
              color: type.color,
            ),
          ),
        ],
      ),
    );
  }
}
