import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_remote_data_source.dart';
import 'user_firestore_data_source.dart';

/// دستور AGENTS-8: صفر try-catch هنا — أخطاء Firebase تصل للمستودع كما هي
/// وهو يحوّلها عبر mapAuthCallError إلى Either. أكواد Firebase النصية
/// ('user-not-found'...) معرفات SDK خارجية وليست نصوص واجهة.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final UserFirestoreDataSource _userStore;

  AuthRemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  }) : _firebaseAuth = firebaseAuth,
       _userStore = UserFirestoreDataSource(firestore: firestore);

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();

  @override
  Future<void> resetPassword(String email) {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> saveUserToFirestore({
    required String uid,
    required String name,
    required String email,
    String? phoneNumber,
    DateTime? dateOfBirth,
  }) {
    return _userStore.saveUserToFirestore(
      uid: uid,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
    );
  }

  @override
  Future<Map<String, dynamic>?> getUserFromFirestore(String uid) {
    return _userStore.getUserFromFirestore(uid);
  }

  @override
  Future<void> updateUserInFirestore({
    required String uid,
    required Map<String, dynamic> userData,
  }) {
    return _userStore.updateUserInFirestore(uid: uid, userData: userData);
  }

  @override
  User? get currentUser => _firebaseAuth.currentUser;
}
