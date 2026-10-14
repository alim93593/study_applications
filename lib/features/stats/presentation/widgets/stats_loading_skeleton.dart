import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/widgets/shimmer_box.dart';

/// هياكل تحميل لشاشة الإحصائيات (بطاقة تركيز + بطاقتا مؤشرات)
/// حتى تصل الجلسات والمهام من Firestore.
/// Why: الشيمر يوحي بتحميل حيّ بدل صناديق ميتة.
class StatsLoadingSkeleton extends StatelessWidget {
  const StatsLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.mutedCard;
    return Column(
      children: [
        for (final height in const [140.0, 110.0, 110.0])
          ShimmerBox(
            child: Container(
              width: double.infinity,
              height: height,
              decoration: BoxDecoration(
                color: context.colors.card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.colors.softBorder),
              ),
              alignment: Alignment.center,
              child: Container(
                width: 120,
                height: 14,
                decoration: BoxDecoration(
                  color: fill,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ),
        const SizedBox(height: 16),
      ],
    );
  }
}
