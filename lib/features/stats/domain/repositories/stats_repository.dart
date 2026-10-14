import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/study_session.dart';

/// واجهة مستودع جلسات المذاكرة (قراءة ستريم + كتابة Either).
abstract class StatsRepository {
  Stream<List<StudySession>> watchSessions();

  Future<Either<Failure, void>> addSession(StudySession session);
}
