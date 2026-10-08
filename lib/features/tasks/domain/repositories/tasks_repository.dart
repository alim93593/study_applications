import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/task_entity.dart';

abstract class TasksRepository {
  Stream<List<TaskEntity>> watchTasks();

  Future<Either<Failure, void>> addTask(TaskEntity task);

  Future<Either<Failure, void>> updateTask(TaskEntity task);

  Future<Either<Failure, void>> toggleComplete(
    String id, {
    required bool completed,
  });

  Future<Either<Failure, void>> deleteTask(String id);
}
