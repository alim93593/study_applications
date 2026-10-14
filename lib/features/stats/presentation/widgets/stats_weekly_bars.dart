import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

/// مخطط الأعمدة الأسبوعي (7 أيام) — أعمدة بيضا على خلفية متدرجة.
/// Why: النسخة السابقة كانت ألوان ثابتة بتختفي على الدارك — دلوقتي
/// الأعمدة بيضا والنص أبيض لأنها جوه بطاقة متدرجة.
class StatsWeeklyBars extends StatelessWidget {
  const StatsWeeklyBars({
    super.key,
    required this.bars,
    required this.labels,
  });

  final List<double> bars;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final maxVal = bars.fold<double>(0, (a, b) => a > b ? a : b);
    return Column(
      children: [
        SizedBox(
          height: 88,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (var i = 0; i < 7; i++)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: _Bar(
                      ratio: maxVal == 0 || i >= bars.length
                          ? 0.0
                          : (bars[i] / maxVal).clamp(0.0, 1.0).toDouble(),
                      isRecent: i >= 5,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            for (var i = 0; i < 7; i++)
              Expanded(
                child: Center(
                  child: Text(
                    i < labels.length ? labels[i] : '',
                    style: AppTextStyles.captionGlass.copyWith(
                      color: Colors.white.withValues(
                        alpha: i >= 5 ? 1.0 : 0.55,
                      ),
                      fontWeight: i >= 5 ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.ratio, required this.isRecent});

  final double ratio;
  final bool isRecent;

  @override
  Widget build(BuildContext context) {
    final height = 8.0 + ratio * 80.0;
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: isRecent
            ? Colors.white
            : Colors.white.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(6),
        boxShadow: isRecent
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
    );
  }
}
