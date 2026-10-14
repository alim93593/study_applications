import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:study_for_ever/features/home/presentation/cubit/home_cubit.dart';
import 'package:study_for_ever/features/stats/domain/entities/study_session.dart';
import 'package:study_for_ever/features/tasks/domain/entities/task_entity.dart';

import 'home_test_fixtures.dart';

void main() {
  group('HomeCubit', () {
    late StreamController<List<TaskEntity>> tasksC;
    late StreamController<List<StudySession>> sessionsC;
    late HomeCubit cubit;

    setUp(() {
      tasksC = StreamController<List<TaskEntity>>();
      sessionsC = StreamController<List<StudySession>>();
      cubit = HomeCubit(
        tasksRepository: FakeTasksRepo(tasksC),
        statsRepository: FakeStatsRepo(sessionsC),
      );
    });

    tearDown(() async {
      await cubit.close();
      await tasksC.close();
      await sessionsC.close();
    });

    Future<void> pump() => Future<void>.delayed(Duration.zero);

    test('computes today tasks, focus hours and completion from streams',
        () async {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      tasksC.add([
        buildTask(id: '1', dueDate: today),
        buildTask(id: '2', status: TaskStatus.completed, dueDate: today),
        buildTask(id: '3', status: TaskStatus.draft),
      ]);
      sessionsC.add([buildSession(minutes: 90, date: now)]);
      await pump();

      expect(cubit.state.todayTasksDisplay, '2');
      expect(cubit.state.focusHoursDisplay, '1.5');
      expect(cubit.state.completionDisplay, '50%');
      expect(cubit.state.isLoading, isFalse);
    });

    test('recomputes when a new emission arrives', () async {
      tasksC.add([]);
      sessionsC.add([]);
      await pump();
      expect(cubit.state.todayTasksDisplay, '0');

      tasksC.add([buildTask(id: '1', dueDate: DateTime.now())]);
      await pump();
      expect(cubit.state.todayTasksDisplay, '1');
    });

    test('keeps defaults while streams are silent', () {
      expect(cubit.state.todayTasksDisplay, '0');
      expect(cubit.state.focusHoursDisplay, '0.0');
      expect(cubit.state.completionDisplay, '0%');
      expect(cubit.state.isLoading, isTrue);
    });
  });
}
