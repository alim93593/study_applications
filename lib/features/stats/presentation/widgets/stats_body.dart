import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/stats_cubit.dart';
import '../cubit/stats_state.dart';
import 'stats_distribution.dart';
import 'stats_focus_card.dart';
import 'stats_loading_skeleton.dart';
import 'stats_milestones.dart';
import 'stats_progress_cards.dart';

/// محتوى الإحصائيات: هياكل تحميل أول ما تفتح الصفحة ثم البطاقات الحقيقية.
class StatsBody extends StatelessWidget {
  const StatsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<StatsCubit, StatsState, bool>(
      selector: (s) => s.isLoading,
      builder: (context, isLoading) {
        if (isLoading) return const StatsLoadingSkeleton();
        return const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatsFocusCard(),
            SizedBox(height: 16),
            StatsProgressCards(),
            SizedBox(height: 16),
            StatsDistribution(),
            SizedBox(height: 24),
            StatsMilestones(),
          ],
        );
      },
    );
  }
}
