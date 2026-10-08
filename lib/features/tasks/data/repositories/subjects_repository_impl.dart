import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/localization/new_task_strings.dart';
import '../../../../core/services/connectivity_service.dart';
import '../../../../core/services/preferences_service.dart';
import '../../domain/repositories/subjects_repository.dart';
import '../datasources/subjects_remote_data_source.dart';

/// الالتقاط + فحص الاتصال قبل Firestore (AGENTS-8: try-catch هنا فقط).
/// يزرع المواد الافتراضية مرة واحدة عند أول اشتراك أونلاين.
class SubjectsRepositoryImpl implements SubjectsRepository {
  final SubjectsRemoteDataSource _dataSource;
  final ConnectivityService _connectivity;
  final PreferencesService _prefs;

  static const List<String> seedSubjects = [
    'Philosophy',
    'Literature',
    'Art History',
    'Theology',
  ];

  SubjectsRepositoryImpl({
    required SubjectsRemoteDataSource dataSource,
    required ConnectivityService connectivity,
    required PreferencesService prefs,
  }) : _dataSource = dataSource,
       _connectivity = connectivity,
       _prefs = prefs;

  @override
  Stream<List<String>> watchSubjects() async* {
    if (!await _connectivity.isConnected) {
      yield const <String>[];
      return;
    }
    if (!_prefs.subjectsSeeded) {
      await _seedDefaults();
    }
    yield* _dataSource.watchSubjects().transform(
      StreamTransformer.fromHandlers(
        handleError: (Object _, StackTrace _, EventSink<List<String>> sink) {
          sink.add(const <String>[]);
        },
      ),
    );
  }

  Future<void> _seedDefaults() async {
    try {
      for (final name in seedSubjects) {
        await _dataSource.addSubject(name);
      }
      await _prefs.setSubjectsSeeded(true);
    } catch (_) {
      // Seeding failed (offline/race) — flag stays false, retry next watch.
    }
  }

  @override
  Future<Either<Failure, void>> addSubject(String name) async {
    if (!await _connectivity.isConnected) {
      return Left(ServerFailure(AppStrings.noInternetConnection));
    }
    try {
      await _dataSource.addSubject(name);
      return const Right(null);
    } catch (_) {
      return Left(ServerFailure(NewTaskStrings.subjectAddFailed));
    }
  }
}
