import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/schedule_entry.dart';
import '../cubit/schedule_state.dart';
import 'schedule_entry_details.dart';
import 'schedule_resource_card.dart';

/// بطاقة عنصر زمني واحدة كما في تصميم Daily Rhythm (شريط جانبي + أيقونة النوع).
class ScheduleTimelineItem extends StatelessWidget {
  final ScheduleEntryView entry;

  const ScheduleTimelineItem({super.key, required this.entry});

  IconData get _typeIcon {
    switch (entry.type) {
      case ScheduleEntryType.lecture:
        return Icons.school_outlined;
      case ScheduleEntryType.lab:
        return Icons.science_outlined;
      case ScheduleEntryType.peerReview:
        return Icons.groups_outlined;
      case ScheduleEntryType.resource:
        return Icons.menu_book_outlined;
      case ScheduleEntryType.deepFocus:
        return Icons.timer_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (entry.isResource) return ScheduleResourceCard(entry: entry);
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.colors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.softBorder),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 4, color: AppColors.primary),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            entry.typeLabel.toUpperCase(),
                            style: AppTextStyles.labelMedium.copyWith(
                              color: AppColors.primary,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Icon(_typeIcon, size: 20, color: AppColors.primary),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      entry.title,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: context.colors.textPrimary,
                      ),
                    ),
                    ScheduleEntryDetails(entry: entry),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
