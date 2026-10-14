import 'package:flutter/material.dart';

import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/schedule_entry.dart';
import '../cubit/schedule_state.dart';
import 'schedule_entry_details.dart';
import 'schedule_resource_card.dart';

/// بطاقة عنصر زمني واحدة كما في تصميم Daily Rhythm (شريط جانبي + أيقونة النوع).
/// Why: tap يفتح صفحة تعديل المهمة مباشرة (quick edit) — الإدارة الكاملة
/// تفضل في صفحة المهام (لا تكرار واجهات).
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

  void _openEdit(BuildContext context) {
    final task = entry.task;
    if (task == null) return;
    AppNavigator.push(AppRouter.newTask, arguments: task);
  }

  @override
  Widget build(BuildContext context) {
    if (entry.isResource) return ScheduleResourceCard(entry: entry);
    return GestureDetector(
      onTap: () => _openEdit(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: context.colors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.colors.softBorder),
          boxShadow: const [
            BoxShadow(
              color: AppColors.softShadow,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
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
      ),
    );
  }
}
