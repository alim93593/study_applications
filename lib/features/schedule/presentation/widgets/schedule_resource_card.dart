import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/schedule_state.dart';

/// بطاقة "Resource Library" (تدرّج كحلي) — مستخرجة من بطاقة العنصر الزمني.
class ScheduleResourceCard extends StatelessWidget {
  final ScheduleEntryView entry;

  const ScheduleResourceCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [AppColors.primaryMid, AppColors.primaryDark],
        ),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            right: 16,
            top: 0,
            bottom: 0,
            child: Icon(
              Icons.menu_book_rounded,
              size: 64,
              color: Colors.white.withValues(alpha: 0.25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.title,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  entry.description,
                  style: AppTextStyles.captionGlass.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
