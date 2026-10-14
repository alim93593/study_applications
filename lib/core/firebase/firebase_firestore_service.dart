import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_paths.dart';

/// المسؤولية الوحيدة: عمليات Firestore (عام + ملفات المستخدمين).
/// Why: تقسيم FirebaseService الكبير للاحترام بقاعدة 100 سطر لكل ملف.
class FirebaseFirestoreService {
  final FirebaseFirestore _firestore;

  FirebaseFirestoreService({required FirebaseFirestore firestore})
    : _firestore = firestore;

  Future<DocumentReference> addDocument({
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    return await _firestore.collection(collection).add(data);
  }

  Future<DocumentSnapshot> getDocument({
    required String collection,
    required String documentId,
  }) async {
    return await _firestore.collection(collection).doc(documentId).get();
  }

  Future<void> updateDocument({
    required String collection,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection(collection).doc(documentId).update(data);
  }

  Future<void> deleteDocument({
    required String collection,
    required String documentId,
  }) async {
    await _firestore.collection(collection).doc(documentId).delete();
  }

  Stream<QuerySnapshot> getCollectionStream({
    required String collection,
    Query<Map<String, dynamic>>? query,
  }) {
    final ref = _firestore.collection(collection);
    return (query ?? ref).snapshots();
  }

  /// باجنبيشن: جلب صفحة واحدة بعد مستند معيّن (cursor-based).
  /// Why: تحميل كل المستندات دفعة واحدة يبطّأ التطبيق مع آلاف المستندات.
  Future<QuerySnapshot<Map<String, dynamic>>> getCollectionPage({
    required String collection,
    required int limit,
    DocumentSnapshot<Map<String, dynamic>>? startAfter,
    String orderBy = 'createdAt',
    bool descending = true,
  }) {
    Query<Map<String, dynamic>> ref = _firestore
        .collection(collection)
        .orderBy(orderBy, descending: descending)
        .limit(limit);
    if (startAfter != null) {
      ref = ref.startAfterDocument(startAfter);
    }
    return ref.get();
  }

  /// باجنبيشن real-time: أول صفحة مع تحديثات حية.
  Stream<QuerySnapshot<Map<String, dynamic>>> getCollectionPageStream({
    required String collection,
    required int limit,
    String orderBy = 'createdAt',
    bool descending = true,
  }) {
    return _firestore
        .collection(collection)
        .orderBy(orderBy, descending: descending)
        .limit(limit)
        .snapshots();
  }

  Future<void> saveUserToFirestore({
    required String uid,
    required Map<String, dynamic> userData,
  }) async {
    await _firestore.collection(FirestorePaths.users).doc(uid).set(userData);
  }

  Future<DocumentSnapshot> getUserFromFirestore(String uid) async {
    return await _firestore.collection(FirestorePaths.users).doc(uid).get();
  }
}
