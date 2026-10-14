import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/widgets/shimmer_box.dart';

/// هياكل تحميل لشاشة الجدول (بطاقة تقدّم + عناصر خط زمني وهمية)
/// حتى تصل بيانات المهام من Firestore — لا "فارغة كاذبة" أبدًا.
/// Why: الشيمر يوحي بتحميل حيّ بدل صناديق ميتة.
class ScheduleLoadingSkeleton extends StatelessWidget {
  const ScheduleLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.mutedCard;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerBox(
          child: Container(
            width: double.infinity,
            height: 88,
            decoration: BoxDecoration(
              color: fill,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(height: 20),
        for (var i = 0; i < 3; i++) ...[
          ShimmerBox(
            borderRadius: 6,
            child: Container(
              width: 72,
              height: 12,
              decoration: BoxDecoration(
                color: fill,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          const SizedBox(height: 8),
          ShimmerBox(
            child: Container(
              width: double.infinity,
              height: 72,
              decoration: BoxDecoration(
                color: context.colors.card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.colors.softBorder),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ],
    );
  }
}
