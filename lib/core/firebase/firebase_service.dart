import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'firebase_auth_service.dart';
import 'firebase_firestore_service.dart';
import 'firebase_storage_service.dart';

/// Facade يجمّع الخدمات الثلاث حسب المسؤولية (Auth / Firestore / Storage).
/// Why: تقسيم الملف الأصلي (134 سطر) لقاعدة 100 سطر بدل تكرار الحقول.
class FirebaseService {
  final FirebaseAuthService auth;
  final FirebaseFirestoreService firestore;
  final FirebaseStorageService storage;

  FirebaseService({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  }) : auth = FirebaseAuthService(auth: auth),
       firestore = FirebaseFirestoreService(firestore: firestore),
       storage = FirebaseStorageService(storage: storage);
}
