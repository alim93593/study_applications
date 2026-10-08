import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/localization/stats_strings.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/stats_cubit.dart';
import '../widgets/stats_distribution.dart';
import '../widgets/stats_focus_card.dart';
import '../widgets/stats_milestones.dart';
import '../widgets/stats_progress_cards.dart';

/// شاشة "إحصائيات المذاكرة" (Academic Performance) — tab داخل الـ Shell.
class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<StatsCubit>(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StatsStrings.statsTitle.tr(),
              style: AppTextStyles.displayMedium.copyWith(
                color: context.colors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(StatsStrings.statsSubtitle.tr(), style: AppTextStyles.bodyMutedSurface),
            const SizedBox(height: 16),
            const StatsFocusCard(),
            const SizedBox(height: 16),
            const StatsProgressCards(),
            const SizedBox(height: 16),
            const StatsDistribution(),
            const SizedBox(height: 24),
            const StatsMilestones(),
          ],
        ),
      ),
    );
  }
}
