import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/firebase/firebase_service.dart';
import '../../../../core/firebase/firestore_paths.dart';

abstract class SubjectsRemoteDataSource {
  Stream<List<String>> watchSubjects();

  Future<void> addSubject(String name);
}

/// تنفيذ Firestore لمسار userSubjects عبر FirebaseService.
/// Why (الدستور): **صفر try-catch هنا** + **صفر مسارات hardcoded** —
/// الـ DataSource يرفع الخطأ كما هو والمسارات من FirestorePaths.
class SubjectsRemoteDataSourceImpl implements SubjectsRemoteDataSource {
  final FirebaseService _firebase;

  SubjectsRemoteDataSourceImpl({required FirebaseService firebase})
    : _firebase = firebase;

  String? get _path {
    final uid = _firebase.auth.currentUser?.uid;
    return uid == null ? null : FirestorePaths.userSubjects(uid);
  }

  @override
  Stream<List<String>> watchSubjects() {
    final path = _path;
    if (path == null) {
      return Stream<List<String>>.value(const []);
    }
    return _firebase.firestore
        .getCollectionStream(collection: path)
        .map<List<String>>((snapshot) {
          final names =
              snapshot.docs
                  .map(
                    (doc) =>
                        (doc.data() as Map<String, dynamic>)['name']
                            as String?,
                  )
                  .where((name) => name != null && name.trim().isNotEmpty)
                  .map((name) => name!.trim())
                  .toSet()
                  .toList()
                ..sort();
          return names;
        });
  }

  @override
  Future<void> addSubject(String name) {
    final path = _path;
    if (path == null) {
      throw StateError('subjects: cannot write without a signed-in user');
    }
    return _firebase.firestore.addDocument(
      collection: path,
      data: {
        'name': name.trim(),
        'createdAt': Timestamp.fromDate(DateTime.now()),
      },
    );
  }
}
