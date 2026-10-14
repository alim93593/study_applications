import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/localization/tasks_strings.dart';
import '../../../../core/services/connectivity_service.dart';
import '../../domain/entities/task_entity.dart';
import '../datasources/tasks_remote_data_source.dart';
import '../models/task_model.dart';

/// منطق الباجبنيشن cursor-based للمهام — مستخرج من RepositoryImpl
/// لاحترام قاعدة 100 سطر لكل ملف.
/// Why: أول صفحة real-time (snapshots) + صفحات تالية one-time (get).
class TasksPagination {
  final TasksRemoteDataSource dataSource;
  final ConnectivityService connectivity;

  /// مؤشر آخر مستند — للـ cursor.
  DocumentSnapshot<Map<String, dynamic>>? lastDocument;

  TasksPagination({required this.dataSource, required this.connectivity});

  Stream<List<TaskEntity>> watchFirstPage({int limit = 20}) async* {
    if (!await connectivity.isConnected) {
      yield const <TaskEntity>[];
      return;
    }
    yield* dataSource
        .watchTasksPage(limit: limit)
        .transform(
          StreamTransformer.fromHandlers(
            handleError:
                (
                  Object error,
                  StackTrace _,
                  EventSink<QuerySnapshot<Map<String, dynamic>>> sink,
                ) {
                  sink.addError(error);
                },
            handleData:
                (
                  QuerySnapshot<Map<String, dynamic>> snapshot,
                  EventSink<QuerySnapshot<Map<String, dynamic>>> sink,
                ) {
                  if (snapshot.docs.isNotEmpty) {
                    lastDocument = snapshot.docs.last;
                  }
                  sink.add(snapshot);
                },
          ),
        )
        .map<List<TaskEntity>>(TaskModel.fromSnapshot)
        .handleError((_) => <TaskEntity>[]);
  }

  Future<Either<Failure, List<TaskEntity>>> nextPage({
    int limit = 20,
  }) async {
    if (!await connectivity.isConnected) {
      return Left(ServerFailure(AppStrings.noInternetConnection));
    }
    final cursor = lastDocument;
    if (cursor == null) {
      return Right(<TaskEntity>[]);
    }
    try {
      final snapshot = await dataSource.getTasksAfter(
        limit: limit,
        startAfter: cursor,
      );
      if (snapshot.docs.isNotEmpty) {
        lastDocument = snapshot.docs.last;
      }
      return Right(TaskModel.fromSnapshot(snapshot));
    } catch (_) {
      return Left(ServerFailure(TasksStrings.taskLoadFailed));
    }
  }
}
