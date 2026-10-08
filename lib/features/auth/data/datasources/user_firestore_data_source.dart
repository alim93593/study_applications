import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/firebase/firestore_paths.dart';

/// عمليات كتابة/قراءة ملف المستخدم على Firestore.
/// Why: استخرجناها من AuthRemoteDataSourceImpl عشان يفضل تحت 100 سطر.
/// دستور AGENTS-8: صفر try-catch هنا — الأخطاء تصل للمستودع كما هي وهو
/// الوحيد الذي يلتقطها ويحوّلها إلى Either.
class UserFirestoreDataSource {
  final FirebaseFirestore _firestore;

  UserFirestoreDataSource({required FirebaseFirestore firestore})
    : _firestore = firestore;

  Future<void> saveUserToFirestore({
    required String uid,
    required String name,
    required String email,
    String? phoneNumber,
    DateTime? dateOfBirth,
  }) {
    return _firestore.collection(FirestorePaths.users).doc(uid).set({
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<Map<String, dynamic>?> getUserFromFirestore(String uid) async {
    final doc =
        await _firestore.collection(FirestorePaths.users).doc(uid).get();
    return doc.data();
  }

  Future<void> updateUserInFirestore({
    required String uid,
    required Map<String, dynamic> userData,
  }) {
    return _firestore.collection(FirestorePaths.users).doc(uid).update({
      ...userData,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
