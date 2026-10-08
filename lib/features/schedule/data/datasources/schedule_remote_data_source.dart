import '../../../../core/firebase/firebase_service.dart';
import '../../../../core/firebase/firestore_paths.dart';
import '../../domain/entities/schedule_entry.dart';

abstract class ScheduleRemoteDataSource {
  Stream<List<ScheduleEntry>> watchToday();
}

/// قراءة عناصر اليوم من users/{uid}/schedule — **صفر try-catch** (دستور الـDataSources).
class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  final FirebaseService _firebase;

  ScheduleRemoteDataSourceImpl({required FirebaseService firebase})
    : _firebase = firebase;

  String? get _path {
    final uid = _firebase.auth.currentUser?.uid;
    return uid == null ? null : FirestorePaths.userSchedule(uid);
  }

  @override
  Stream<List<ScheduleEntry>> watchToday() {
    final path = _path;
    if (path == null) return Stream<List<ScheduleEntry>>.value(const []);
    final now = DateTime.now();
    final dayStart = DateTime(now.year, now.month, now.day);
    return _firebase.firestore
        .getCollectionStream(collection: path)
        .map<List<ScheduleEntry>>((snapshot) {
          final entries =
              snapshot.docs
                  .map(
                    (doc) => ScheduleEntry.fromMap(
                      doc.data() as Map<String, dynamic>,
                      id: doc.id,
                    ),
                  )
                  .where((e) => !e.startTime.isBefore(dayStart))
                  .toList()
                ..sort((a, b) => a.startTime.compareTo(b.startTime));
          return entries;
        });
  }
}
