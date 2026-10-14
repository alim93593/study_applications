import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../stats/domain/entities/study_session.dart';
import '../../../stats/presentation/cubit/stats_label_keys.dart';
import '../../../tasks/domain/entities/task_entity.dart';
import '../../../tasks/domain/repositories/tasks_repository.dart';
import '../../../stats/domain/repositories/stats_repository.dart';
import 'home_state.dart';

/// شاشة الفوكس: مهام اليوم + تركيز اليوم + نسبة الإنجاز (بيانات حقيقية).
/// Why: القيم كانت وهمية (12/48/250) بلا مصدر — كل الحسابات هنا صفر UI.
class HomeCubit extends Cubit<HomeState> {
  final TasksRepository _tasksRepository;
  final StatsRepository _statsRepository;
  StreamSubscription<List<TaskEntity>>? _tasksSub;
  StreamSubscription<List<StudySession>>? _sessionsSub;
  List<TaskEntity> _tasks = const [];
  List<StudySession> _sessions = const [];

  HomeCubit({
    required TasksRepository tasksRepository,
    required StatsRepository statsRepository,
  }) : _tasksRepository = tasksRepository,
       _statsRepository = statsRepository,
       super(const HomeState()) {
    _tasksSub = _tasksRepository.watchTasks().listen((tasks) {
      _tasks = tasks;
      _recompute();
    });
    _sessionsSub = _statsRepository.watchSessions().listen((sessions) {
      _sessions = sessions;
      _recompute();
    });
  }

  void _recompute() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tasks = _tasks.where((t) => t.status != TaskStatus.draft).toList();
    final todayTasks = tasks
        .where(
          (t) =>
              t.dueDate != null &&
              DateTime(t.dueDate!.year, t.dueDate!.month, t.dueDate!.day) ==
                  today,
        )
        .length;
    final completed = tasks.where((t) => t.status == TaskStatus.completed).length;
    final focusMinutes = _sessions
        .where(
          (s) =>
              DateTime(s.date.year, s.date.month, s.date.day) == today,
        )
        .fold<int>(0, (sum, s) => sum + s.minutes);
    final completion = tasks.isEmpty ? 0.0 : completed / tasks.length;

    // آخر 7 أيام: الاثنين (1) حتى الأحد (7) — حسب تقويم الأسبوع العربي.
    final weekly = List<int>.filled(7, 0);
    for (var i = 0; i < 7; i++) {
      final day = today.subtract(Duration(days: 6 - i));
      weekly[i] = _sessions
          .where(
            (s) =>
                DateTime(s.date.year, s.date.month, s.date.day) == day,
          )
          .fold<int>(0, (sum, s) => sum + s.minutes);
    }
    final labels = List.generate(
      7,
      (i) {
        final day = today.subtract(Duration(days: 6 - i));
        return StatsLabelKeys.weekdayKey(day.weekday).tr();
      },
    );

    emit(
      HomeState(
        todayTasksDisplay: '$todayTasks',
        focusHoursDisplay: (focusMinutes / 60).toStringAsFixed(1),
        completionDisplay: '${(completion * 100).round()}%',
        isLoading: false,
        weeklyFocusMinutes: weekly,
        weeklyDayLabels: labels,
        weeklyTotalMinutes: weekly.fold<int>(0, (a, b) => a + b),
      ),
    );
  }

  @override
  Future<void> close() {
    _tasksSub?.cancel();
    _sessionsSub?.cancel();
    return super.close();
  }
}
