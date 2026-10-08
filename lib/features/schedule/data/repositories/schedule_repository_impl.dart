import 'dart:async';

import '../../../../core/services/connectivity_service.dart';
import '../../domain/entities/schedule_entry.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../datasources/schedule_remote_data_source.dart';

/// الالتقاط + فحص الاتصال قبل التعامل مع Firestore (نفس نمط مستودع المهام).
class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource _dataSource;
  final ConnectivityService _connectivity;

  ScheduleRepositoryImpl({
    required ScheduleRemoteDataSource dataSource,
    required ConnectivityService connectivity,
  }) : _dataSource = dataSource,
       _connectivity = connectivity;

  @override
  Stream<List<ScheduleEntry>> watchToday() async* {
    if (!await _connectivity.isConnected) {
      yield const <ScheduleEntry>[];
      return;
    }
    yield* _dataSource.watchToday().transform(
      StreamTransformer.fromHandlers(
        handleError:
            (Object _, StackTrace _, EventSink<List<ScheduleEntry>> sink) {
              sink.add(const <ScheduleEntry>[]);
            },
      ),
    );
  }
}
