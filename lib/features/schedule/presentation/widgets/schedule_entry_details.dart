import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/schedule_state.dart';

/// تفاصيل العنصر الزمني داخل بطاقته (وصف/موقع/شريط تقدم/مشاركون).
class ScheduleEntryDetails extends StatelessWidget {
  final ScheduleEntryView entry;

  const ScheduleEntryDetails({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (entry.description.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            entry.description,
            style: AppTextStyles.bodyMutedSurface.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
        ],
        if (entry.location.isNotEmpty) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: context.colors.textSecondary,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  entry.location,
                  style: AppTextStyles.captionGlass.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
        if (entry.progress > 0) ...[
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: entry.progress,
              minHeight: 6,
              color: AppColors.primary,
              backgroundColor: context.colors.mutedCard,
            ),
          ),
        ],
        if (entry.participants.isNotEmpty) ...[
          const SizedBox(height: 12),
          Row(
            children: [
              for (final name in entry.participants)
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: context.colors.chipBackground,
                    child: Text(
                      name,
                      style: AppTextStyles.captionGlass.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}
