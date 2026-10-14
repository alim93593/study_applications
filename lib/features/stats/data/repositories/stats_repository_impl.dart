import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/localization/stats_strings.dart';
import '../../../../core/services/connectivity_service.dart';
import '../../domain/entities/study_session.dart';
import '../../domain/repositories/stats_repository.dart';
import '../datasources/stats_remote_data_source.dart';

/// الالتقاط + فحص الاتصال قبل Firestore (نفس نمط باقي المستودعات).
class StatsRepositoryImpl implements StatsRepository {
  final StatsRemoteDataSource _dataSource;
  final ConnectivityService _connectivity;

  StatsRepositoryImpl({
    required StatsRemoteDataSource dataSource,
    required ConnectivityService connectivity,
  }) : _dataSource = dataSource,
       _connectivity = connectivity;

  @override
  Stream<List<StudySession>> watchSessions() async* {
    if (!await _connectivity.isConnected) {
      yield const <StudySession>[];
      return;
    }
    yield* _dataSource.watchSessions().transform(
      StreamTransformer.fromHandlers(
        handleError:
            (Object _, StackTrace _, EventSink<List<StudySession>> sink) {
              sink.add(const <StudySession>[]);
            },
      ),
    );
  }

  @override
  Future<Either<Failure, void>> addSession(StudySession session) async {
    if (!await _connectivity.isConnected) {
      return Left(ServerFailure(AppStrings.noInternetConnection));
    }
    try {
      await _dataSource.addSession(session);
      return const Right(null);
    } catch (_) {
      return Left(ServerFailure(StatsStrings.sessionSaveFailed));
    }
  }
}
