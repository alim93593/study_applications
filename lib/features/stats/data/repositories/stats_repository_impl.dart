import 'dart:async';

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
}
