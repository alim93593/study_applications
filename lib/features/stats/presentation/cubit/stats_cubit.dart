import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/study_session.dart';
import '../../domain/repositories/stats_repository.dart';
import '../../domain/stats_calculator.dart';
import '../../../../core/localization/stats_strings.dart';
import '../../../tasks/domain/entities/task_entity.dart';
import '../../../tasks/domain/repositories/tasks_repository.dart';
import 'stats_state.dart';

/// يجمع جلسات التركيز ومهام المستخدم ويحسب كل أرقام الشاشة (صفر منطق واجهات).
class StatsCubit extends Cubit<StatsState> {
  final StatsRepository _statsRepository;
  final TasksRepository _tasksRepository;
  StreamSubscription<List<StudySession>>? _sessionsSub;
  StreamSubscription<List<TaskEntity>>? _tasksSub;
  List<StudySession> _sessions = const [];
  List<TaskEntity> _tasks = const [];

  StatsCubit({
    required StatsRepository statsRepository,
    required TasksRepository tasksRepository,
  }) : _statsRepository = statsRepository,
       _tasksRepository = tasksRepository,
       super(const StatsState()) {
    _sessionsSub = _statsRepository.watchSessions().listen((sessions) {
      _sessions = sessions;
      _recompute();
    });
    _tasksSub = _tasksRepository.watchTasks().listen((tasks) {
      _tasks = tasks;
      _recompute();
    });
  }

  void _recompute() {
    final now = DateTime.now();
    final completed = _tasks
        .where((t) => t.status == TaskStatus.completed)
        .toList();
    final total = _tasks.length;
    final goalValue = total == 0 ? 0.0 : completed.length / total;
    final delta = StatsCalculator.consistencyDelta(_sessions, now);
    final milestones = <MilestoneView>[
      if (StatsCalculator.readingMilestone(_sessions))
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
    emit(
      StatsState(
        focusHoursDisplay: StatsCalculator.focusHours(
          _sessions,
        ).toStringAsFixed(1),
        weeklyBars: StatsCalculator.weeklyBars(_sessions, now),
        completedDisplay: '${completed.length}/$total',
        weeklyGoalValue: goalValue.clamp(0, 1),
        weeklyGoalDisplay: '${(goalValue * 100).round()}%',
        avgSessionDisplay: '${StatsCalculator.avgSessionMinutes(_sessions)}',
        consistencyDisplay: delta >= 0
            ? StatsStrings.consistencyUp.tr(args: ['$delta'])
            : StatsStrings.consistencyDown.tr(args: ['${-delta}']),
        distribution: [
          for (final d in StatsCalculator.distribution(_sessions))
            (subject: d.subject, hoursDisplay: '${d.hours.round()}h'),
        ],
        milestones: milestones,
        isLoading: false,
      ),
    );
  }

  @override
  Future<void> close() {
    _sessionsSub?.cancel();
    _tasksSub?.cancel();
    return super.close();
  }
}
