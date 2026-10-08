import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/localization/tasks_strings.dart';
import '../../../../core/services/connectivity_service.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/tasks_repository.dart';
import '../datasources/tasks_remote_data_source.dart';
import '../models/task_model.dart';

/// طبقة الالتقاط الوحيدة المسموح فيها بـ try-catch + **فحص الاتصال قبل أي
/// تعامل مع Firebase** (نفس فلسفة network في main): أوفلاين → فشل مفهوم.
class TasksRepositoryImpl implements TasksRepository {
  final TasksRemoteDataSource _dataSource;
  final ConnectivityService _connectivity;

  TasksRepositoryImpl({
    required TasksRemoteDataSource dataSource,
    required ConnectivityService connectivity,
  }) : _dataSource = dataSource,
       _connectivity = connectivity;

  @override
  Stream<List<TaskEntity>> watchTasks() async* {
    if (!await _connectivity.isConnected) {
      yield const <TaskEntity>[];
      return;
    }
    yield* _dataSource.watchTasks().transform(
      StreamTransformer.fromHandlers(
        handleError:
            (Object _, StackTrace _, EventSink<List<TaskEntity>> sink) {
              sink.add(const <TaskEntity>[]);
            },
      ),
    );
  }

  Future<Either<Failure, void>> _execute(
    Future<void> Function() action, {
    required String errorMessage,
  }) async {
    if (!await _connectivity.isConnected) {
      return Left(ServerFailure(AppStrings.noInternetConnection));
    }
    try {
      await action();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(errorMessage));
    }
  }

  @override
  Future<Either<Failure, void>> addTask(TaskEntity task) {
    return _execute(
      () => _dataSource.addTask(TaskModel.fromEntity(task)),
      errorMessage: TasksStrings.taskAddFailed,
    );
  }

  @override
  Future<Either<Failure, void>> updateTask(TaskEntity task) {
    return _execute(
      () => _dataSource.updateTask(TaskModel.fromEntity(task)),
      errorMessage: TasksStrings.taskUpdateFailed,
    );
  }

  @override
  Future<Either<Failure, void>> toggleComplete(
    String id, {
    required bool completed,
  }) {
    return _execute(
      () => _dataSource.toggleComplete(id, completed: completed),
      errorMessage: TasksStrings.taskUpdateFailed,
    );
  }

  @override
  Future<Either<Failure, void>> deleteTask(String id) {
    return _execute(
      () => _dataSource.deleteTask(id),
      errorMessage: TasksStrings.taskDeleteFailed,
    );
  }
}
