import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/error/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> resetPassword(String email);

  Future<void> saveUserToFirestore({
    required String uid,
    required String name,
    required String email,
    String? phoneNumber,
    DateTime? dateOfBirth,
  });

  Future<Map<String, dynamic>?> getUserFromFirestore(String uid);

  Future<void> updateUserInFirestore({
    required String uid,
    required Map<String, dynamic> userData,
  });

  User? get currentUser;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  }) : _firebaseAuth = firebaseAuth,
       _firestore = firestore;

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw ServerException(message: 'Failed to sign out');
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  @override
  Future<void> saveUserToFirestore({
    required String uid,
    required String name,
    required String email,
    String? phoneNumber,
    DateTime? dateOfBirth,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'dateOfBirth': dateOfBirth,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw ServerException(message: 'Failed to save user data');
    }
  }

  @override
  Future<Map<String, dynamic>?> getUserFromFirestore(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      return doc.data();
    } catch (e) {
      throw ServerException(message: 'Failed to get user data');
    }
  }

  @override
  Future<void> updateUserInFirestore({
    required String uid,
    required Map<String, dynamic> userData,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        ...userData,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw ServerException(message: 'Failed to update user data');
    }
  }

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  AuthException _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return AuthException(
          message: 'No user found with this email',
          statusCode: 404,
        );
      case 'wrong-password':
        return AuthException(message: 'Wrong password', statusCode: 401);
      case 'email-already-in-use':
        return AuthException(message: 'Email already in use', statusCode: 400);
      case 'weak-password':
        return AuthException(message: 'Password is too weak', statusCode: 400);
      case 'invalid-email':
        return AuthException(message: 'Invalid email address', statusCode: 400);
      case 'user-disabled':
        return AuthException(
          message: 'User account is disabled',
          statusCode: 403,
        );
      case 'operation-not-allowed':
        return AuthException(message: 'Operation not allowed', statusCode: 403);
      case 'too-many-requests':
        return AuthException(
          message: 'Too many requests. Please try again later',
          statusCode: 429,
        );
      case 'network-request-failed':
        return AuthException(
          message: 'Network error occurred',
          statusCode: 503,
        );
      default:
        return AuthException(
          message: e.message ?? 'An unknown error occurred',
          statusCode: 500,
        );
    }
  }
}
