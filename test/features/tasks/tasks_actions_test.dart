import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_for_ever/core/error/failures.dart';
import 'package:study_for_ever/features/tasks/domain/entities/task_entity.dart';
import 'package:study_for_ever/features/tasks/domain/repositories/subjects_repository.dart';
import 'package:study_for_ever/features/tasks/domain/repositories/tasks_repository.dart';
import 'package:study_for_ever/features/tasks/presentation/cubit/new_task_cubit.dart';
import 'package:study_for_ever/features/tasks/presentation/cubit/tasks_cubit.dart';

/// noSuchMethod forwarding keeps the fakes short without a mock package.
class FakeTasksRepo implements TasksRepository {
  FakeTasksRepo({Either<Failure, void>? deleteResult})
    : _deleteResult = deleteResult;

  final Either<Failure, void>? _deleteResult;
  String? lastDeletedId;
  TaskEntity? lastUpdated;
  TaskEntity? lastAdded;

  @override
  Stream<List<TaskEntity>> watchTasks() => const Stream.empty();

  @override
  Stream<List<TaskEntity>> watchTasksPage({int limit = 20}) =>
      const Stream.empty();

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasksNextPage({
    int limit = 20,
  }) async => Right(<TaskEntity>[]);

  @override
  Future<Either<Failure, void>> deleteTask(String id) async {
    lastDeletedId = id;
    return _deleteResult ?? const Right(null);
  }

  @override
  Future<Either<Failure, void>> updateTask(TaskEntity task) async {
    lastUpdated = task;
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> addTask(TaskEntity task) async {
    lastAdded = task;
    return const Right(null);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class FakeSubjectsRepo implements SubjectsRepository {
  @override
  Stream<List<String>> watchSubjects() => Stream.value(const <String>[]);

  @override
  Future<Either<Failure, void>> addSubject(String name) async =>
      const Right(null);

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

TaskEntity _task({TaskStatus status = TaskStatus.pending}) {
  return TaskEntity(
    id: 'task-1',
    title: 'Old title',
    subject: 'Philosophy',
    dueDate: DateTime(2026, 10, 10),
    focusLevel: FocusLevel.deep,
    notes: 'old notes',
    status: status,
    createdAt: DateTime(2026, 1, 1),
  );
}

void main() {
  group('TasksCubit delete', () {
    test('emits successMessage on success', () async {
      final cubit = TasksCubit(repository: FakeTasksRepo());
      await cubit.deleteTask('task-1');
      expect(cubit.state.successMessage, isNotEmpty);
    });

    test('emits failureMessage on failure', () async {
      final cubit = TasksCubit(
        repository: FakeTasksRepo(
          deleteResult: Left(ServerFailure('task_delete_failed')),
        ),
      );
      await cubit.deleteTask('task-1');
      expect(cubit.state.failureMessage, isNotEmpty);
      expect(cubit.state.successMessage, isEmpty);
    });
  });

  group('NewTaskCubit edit mode', () {
    late FakeTasksRepo repo;
    late NewTaskCubit cubit;

    setUp(() {
      repo = FakeTasksRepo();
      cubit = NewTaskCubit(
        repository: repo,
        subjectsRepository: FakeSubjectsRepo(),
      );
    });

    tearDown(() => cubit.close());

    test('startEditing prefills the form state', () {
      cubit.startEditing(_task());
      expect(cubit.state.isEditing, isTrue);
      expect(cubit.state.editingId, 'task-1');
      expect(cubit.state.title, 'Old title');
      expect(cubit.state.notes, 'old notes');
      expect(cubit.state.subject, 'Philosophy');
      expect(cubit.state.dueDateDisplay, isNotEmpty);
    });

    test('startEditing(null) keeps create mode', () {
      cubit.startEditing(null);
      expect(cubit.state.isEditing, isFalse);
    });

    test('saving in edit mode calls updateTask with new notes', () async {
      cubit.startEditing(_task());
      cubit.onNotesChanged('updated notes');
      await cubit.submitAsTask();

      expect(repo.lastUpdated, isNotNull);
      expect(repo.lastUpdated!.id, 'task-1');
      expect(repo.lastUpdated!.notes, 'updated notes');
      expect(repo.lastUpdated!.createdAt, DateTime(2026, 1, 1));
      expect(cubit.state.submitted, isTrue);
    });

    test('completed task stays completed after edit save', () async {
      cubit.startEditing(_task(status: TaskStatus.completed));
      await cubit.submitAsTask();
      expect(repo.lastUpdated!.status, TaskStatus.completed);
    });
  });
}
