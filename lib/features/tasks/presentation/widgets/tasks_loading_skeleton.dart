import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors_extension.dart';

/// Placeholder cards shown while tasks stream in from Firestore —
/// so the list never lies with an "empty" state during loading.
class TasksLoadingSkeleton extends StatelessWidget {
  const TasksLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          height: 12,
          decoration: BoxDecoration(
            color: context.colors.mutedCard,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < 3; i++) ...[
          const _SkeletonCard(),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

  @override
  Widget build(BuildContext context) {
    final fill = context.colors.mutedCard;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.softBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(shape: BoxShape.circle, color: fill),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 14,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: fill,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 140,
                  decoration: BoxDecoration(
                    color: fill,
                    borderRadius: BorderRadius.circular(6),
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
