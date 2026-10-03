import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class GlassSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;

  const GlassSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged?.call(!value),
      child: Row(
        children: [
          if (label != null) ...[
            Text(label!, style: AppTextStyles.bodySurface),
            const SizedBox(width: 12),
          ],
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 52,
            height: 28,
            decoration: BoxDecoration(
              color: value
                  ? AppColors.primary.withValues(alpha: 0.2)
                  : AppColors.glassWhite,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: value ? AppColors.primary : AppColors.glassBorder,
                width: 1,
              ),
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: value ? AppColors.primary : AppColors.glassBorder,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: (value ? AppColors.primary : AppColors.glassBorder)
                          .withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
