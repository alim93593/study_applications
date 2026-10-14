import 'package:easy_localization/easy_localization.dart';

import '../../../../core/localization/stats_strings.dart';
import '../../domain/entities/study_session.dart';
import '../../domain/stats_calculator.dart';
import '../../../tasks/domain/entities/task_entity.dart';
import 'stats_state.dart';

/// حسابات الإحصائيات المضمنة (milestones + distribution) — مستخرجة من Cubit
/// لاحترام قاعدة 100 سطر. Why: كل المنطق هنا UI-free.
class StatsComputations {
  static List<MilestoneView> milestones(
    List<StudySession> sessions,
    List<TaskEntity> completed,
  ) {
    return [
      if (StatsCalculator.readingMilestone(sessions))
        MilestoneView(
          title: StatsStrings.milestoneBibliophile.tr(),
          description: StatsStrings.milestoneBibliophileDesc.tr(),
        ),
      if (StatsCalculator.sprintMilestone(
        completed.map((t) => t.completedAt ?? t.createdAt).toList(),
      ))
        MilestoneView(
          title: StatsStrings.milestoneSprint.tr(),
          description: StatsStrings.milestoneSprintDesc.tr(),
        ),
    ];
  }

  static List<({String subject, String hoursDisplay, double progress})>
  distribution(List<StudySession> sessions) {
    final dist = StatsCalculator.distribution(sessions);
    final totalHours = dist.fold<double>(0, (s, d) => s + d.hours);
    return [
      for (final d in dist)
        (
          subject: d.subject,
          hoursDisplay: '${d.hours.round()} ${StatsStrings.unitHours.tr()}',
          progress: totalHours == 0
              ? 0.3
              : (d.hours / totalHours).clamp(0.05, 1.0).toDouble(),
        ),
    ];
  }
}
