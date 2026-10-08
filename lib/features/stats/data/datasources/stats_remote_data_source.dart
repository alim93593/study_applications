import '../../../../core/firebase/firebase_service.dart';
import '../../../../core/firebase/firestore_paths.dart';
import '../../domain/entities/study_session.dart';

abstract class StatsRemoteDataSource {
  Stream<List<StudySession>> watchSessions();
}

/// قراءة جلسات التركيز من users/{uid}/sessions — **صفر try-catch** (الدستور).
class StatsRemoteDataSourceImpl implements StatsRemoteDataSource {
  final FirebaseService _firebase;

  StatsRemoteDataSourceImpl({required FirebaseService firebase})
    : _firebase = firebase;

  String? get _path {
    final uid = _firebase.auth.currentUser?.uid;
    return uid == null ? null : FirestorePaths.userSessions(uid);
  }

  @override
  Stream<List<StudySession>> watchSessions() {
    final path = _path;
    if (path == null) return Stream<List<StudySession>>.value(const []);
    return _firebase.firestore
        .getCollectionStream(collection: path)
        .map<List<StudySession>>((snapshot) {
          final sessions =
              snapshot.docs
                  .map(
                    (doc) => StudySession.fromMap(
                      doc.data() as Map<String, dynamic>,
                      id: doc.id,
                    ),
                  )
                  .toList()
                ..sort((a, b) => b.date.compareTo(a.date));
          return sessions;
        });
  }
}
