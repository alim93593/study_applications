import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:study_for_ever/core/error/failures.dart';
import 'package:study_for_ever/features/stats/domain/entities/study_session.dart';
import 'package:study_for_ever/features/stats/domain/repositories/stats_repository.dart';
import 'package:study_for_ever/features/tasks/domain/entities/task_entity.dart';
import 'package:study_for_ever/features/tasks/domain/repositories/tasks_repository.dart';

/// noSuchMethod forwarding keeps the fakes short without a mock package.
class FakeTasksRepo implements TasksRepository {
  FakeTasksRepo(this.controller);

  final StreamController<List<TaskEntity>> controller;

  @override
  Stream<List<TaskEntity>> watchTasks() => controller.stream;

  @override
  Stream<List<TaskEntity>> watchTasksPage({int limit = 20}) =>
      controller.stream;

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasksNextPage({
    int limit = 20,
  }) async => Right(<TaskEntity>[]);

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class FakeStatsRepo implements StatsRepository {
  FakeStatsRepo(this.controller);

  final StreamController<List<StudySession>> controller;

  @override
  Stream<List<StudySession>> watchSessions() => controller.stream;

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

TaskEntity buildTask({
  required String id,
  TaskStatus status = TaskStatus.pending,
  DateTime? dueDate,
}) {
  return TaskEntity(
    id: id,
    title: 'task $id',
    subject: 'Philosophy',
    dueDate: dueDate,
    status: status,
    createdAt: DateTime(2026, 1, 1),
  );
}

StudySession buildSession({required int minutes, required DateTime date}) {
  return StudySession(
    id: 's$minutes',
    subject: 'Philosophy',
    minutes: minutes,
    date: date,
  );
}
