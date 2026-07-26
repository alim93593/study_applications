import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  FirebaseService({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _auth = auth,
        _firestore = firestore,
        _storage = storage;

  // Auth methods
  User? get currentUser => _auth.currentUser;
  
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Firestore methods
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

  // Storage methods
  Future<String> uploadFile({
    required String path,
    required Uint8List fileBytes,
    String? contentType,
  }) async {
    final ref = _storage.ref().child(path);
    final metadata = SettableMetadata(
      contentType: contentType,
    );
    await ref.putData(fileBytes, metadata);
    return await ref.getDownloadURL();
  }

  Future<void> deleteFile(String path) async {
    await _storage.ref().child(path).delete();
  }

  // User profile methods
  Future<void> updateUserProfile({
    String? displayName,
    String? photoURL,
  }) async {
    final user = _auth.currentUser;
    if (user != null) {
      if (displayName != null) {
        await user.updateDisplayName(displayName);
      }
      if (photoURL != null) {
        await user.updatePhotoURL(photoURL);
      }
    }
  }

  Future<void> saveUserToFirestore({
    required String uid,
    required Map<String, dynamic> userData,
  }) async {
    await _firestore.collection('users').doc(uid).set(userData);
  }

  Future<DocumentSnapshot> getUserFromFirestore(String uid) async {
    return await _firestore.collection('users').doc(uid).get();
  }
}