import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

/// المسؤولية الوحيدة: عمليات Firebase Storage.
/// Why: تقسيم FirebaseService الكبير للاحترام بقاعدة 100 سطر لكل ملف.
class FirebaseStorageService {
  final FirebaseStorage _storage;

  FirebaseStorageService({required FirebaseStorage storage})
    : _storage = storage;

  Future<String> uploadFile({
    required String path,
    required Uint8List fileBytes,
    String? contentType,
  }) async {
    final ref = _storage.ref().child(path);
    final metadata = SettableMetadata(contentType: contentType);
    await ref.putData(fileBytes, metadata);
    return await ref.getDownloadURL();
  }

  Future<void> deleteFile(String path) async {
    await _storage.ref().child(path).delete();
  }
}
