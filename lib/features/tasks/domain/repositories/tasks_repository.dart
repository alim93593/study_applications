import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/task_entity.dart';

abstract class TasksRepository {
  Stream<List<TaskEntity>> watchTasks();

  /// أول صفحة real-time (تحديثات حية للصفحة الأولى فقط).
  Stream<List<TaskEntity>> watchTasksPage({int limit});

  /// دفعة تالية — ترجع فاضي لو مفيش المزيد.
  Future<Either<Failure, List<TaskEntity>>> getTasksNextPage({int limit});

  Future<Either<Failure, void>> addTask(TaskEntity task);

  Future<Either<Failure, void>> updateTask(TaskEntity task);

  Future<Either<Failure, void>> toggleComplete(
    String id, {
    required bool completed,
  });

  Future<Either<Failure, void>> deleteTask(String id);
}
