import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

/// عمود واحد في المخطط الأسبوعي — أبيض على الخلفية المتدرجة للبطاقة.
/// Why: النسخة القديمة كانت primary شفاف فكانت باهتة على الدارك.
class HomeWeeklyBar extends StatelessWidget {
  const HomeWeeklyBar({
    super.key,
    required this.label,
    required this.minutes,
    required this.maxMinutes,
    required this.isToday,
  });

  final String label;
  final int minutes;
  final int maxMinutes;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    final ratio = maxMinutes == 0
        ? 0.0
        : (minutes / maxMinutes).clamp(0.05, 1.0);
    final barHeight = 80.0 * ratio;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (minutes > 0)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '$minutes',
                style: AppTextStyles.captionGlass.copyWith(
                  color: Colors.white.withValues(alpha: isToday ? 1.0 : 0.7),
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                ),
              ),
            ),
          Container(
            height: barHeight < 4 ? 4 : barHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: isToday
                    ? [Colors.white.withValues(alpha: 0.7), Colors.white]
                    : [
                        Colors.white.withValues(alpha: 0.25),
                        Colors.white.withValues(alpha: 0.5),
                      ],
              ),
              borderRadius: BorderRadius.circular(6),
              boxShadow: isToday
                  ? [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.35),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : null,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: AppTextStyles.captionGlass.copyWith(
              color: Colors.white.withValues(alpha: isToday ? 1.0 : 0.55),
              fontWeight: isToday ? FontWeight.w800 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
