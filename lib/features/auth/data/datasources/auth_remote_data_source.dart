import 'package:firebase_auth/firebase_auth.dart';

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
