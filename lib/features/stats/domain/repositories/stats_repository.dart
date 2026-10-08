import '../entities/study_session.dart';

/// واجهة مستودع جلسات المذاكرة.
abstract class StatsRepository {
  Stream<List<StudySession>> watchSessions();
}
