import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';

/// بطاقة "لا توجد بيانات بعد" — بدل اختفاء القسم بالكامل (يبدو ناقصًا).
class StatsEmptyCard extends StatelessWidget {
  const StatsEmptyCard({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colors.mutedCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.hourglass_empty_rounded, color: context.colors.textHint),
          const SizedBox(width: 12),
          Expanded(
            child: Text(message, style: AppTextStyles.bodyMutedSurface),
          ),
        ],
      ),
    );
  }
}
