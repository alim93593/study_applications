import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/firebase/firebase_service.dart';
import '../../../../core/firebase/firestore_paths.dart';

/// باجنبيشن المهام — مستخرج من TasksRemoteDataSourceImpl (قاعدة 100 سطر).
/// Why: تحميل كل المستندات دفعة واحدة يبطّأ التطبيق مع آلاف المستندات.
class TasksPaginationDataSource {
  final FirebaseService _firebase;

  TasksPaginationDataSource({required FirebaseService firebase})
    : _firebase = firebase;

  String? get _path {
    final uid = _firebase.auth.currentUser?.uid;
    return uid == null ? null : FirestorePaths.userTasks(uid);
  }

  /// أول صفحة real-time (تحديثات حية).
  Stream<QuerySnapshot<Map<String, dynamic>>> watchTasksPage({
    int limit = 20,
  }) {
    final path = _path;
    if (path == null) {
      return const Stream<QuerySnapshot<Map<String, dynamic>>>.empty();
    }
    return _firebase.firestore.getCollectionPageStream(
      collection: path,
      limit: limit,
    );
  }

  /// دفعة تالية بعد مستند معيّن (one-time fetch).
  Future<QuerySnapshot<Map<String, dynamic>>> getTasksAfter({
    required int limit,
    required DocumentSnapshot<Map<String, dynamic>> startAfter,
  }) {
    final path = _path;
    if (path == null) {
      throw StateError('No authenticated user');
    }
    return _firebase.firestore.getCollectionPage(
      collection: path,
      limit: limit,
      startAfter: startAfter,
    );
  }
}
