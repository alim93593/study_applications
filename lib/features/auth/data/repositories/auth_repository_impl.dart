import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource authRemoteDataSource,
  }) : _authRemoteDataSource = authRemoteDataSource;

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _authRemoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Get user data from Firestore
      final userData = await _authRemoteDataSource.getUserFromFirestore(
        userCredential.user!.uid,
      );
      
      if (userData != null) {
        final user = UserModel.fromMap(userData).copyWith(
          uid: userCredential.user!.uid,
        );
        return Right(user);
      }
      
      // If no data in Firestore, create from Firebase Auth
      final user = UserModel.fromFirebaseUser(userCredential.user);
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message, statusCode: e.statusCode));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownAuthFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    String? phoneNumber,
    DateTime? dateOfBirth,
  }) async {
    try {
      final userCredential = await _authRemoteDataSource.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Save user data to Firestore
      await _authRemoteDataSource.saveUserToFirestore(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
      );
      
      final user = UserModel(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message, statusCode: e.statusCode));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownAuthFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _authRemoteDataSource.signOut();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure('Failed to sign out'));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    try {
      await _authRemoteDataSource.resetPassword(email);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(AuthFailure('Failed to reset password'));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final firebaseUser = _authRemoteDataSource.currentUser;
      if (firebaseUser != null) {
        final userData = await _authRemoteDataSource.getUserFromFirestore(
          firebaseUser.uid,
        );
        
        if (userData != null) {
          final user = UserModel.fromMap(userData).copyWith(
            uid: firebaseUser.uid,
          );
          return Right(user);
        }
        
        // If no data in Firestore, create from Firebase Auth
        final user = UserModel.fromFirebaseUser(firebaseUser);
        return Right(user);
      }
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure('Failed to get current user'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserProfile(String uid) async {
    try {
      final userData = await _authRemoteDataSource.getUserFromFirestore(uid);
      
      if (userData != null) {
        final user = UserModel.fromMap(userData).copyWith(uid: uid);
        return Right(user);
      }
      
      return Left(AuthFailure('User not found'));
    } catch (e) {
      return Left(AuthFailure('Failed to get user profile'));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserProfile({
    required String uid,
    String? name,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? photoURL,
  }) async {
    try {
      final updateData = <String, dynamic>{};
      
      if (name != null) updateData['name'] = name;
      if (phoneNumber != null) updateData['phoneNumber'] = phoneNumber;
      if (dateOfBirth != null) updateData['dateOfBirth'] = dateOfBirth;
      if (photoURL != null) updateData['photoURL'] = photoURL;
      
      await _authRemoteDataSource.updateUserInFirestore(
        uid: uid,
        userData: updateData,
      );
      
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure('Failed to update user profile'));
    }
  }
}