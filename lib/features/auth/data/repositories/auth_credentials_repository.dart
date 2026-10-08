import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/localization/error_strings.dart';
import '../../../../core/network/offline_guard.dart';
import '../../../../core/services/connectivity_service.dart';
import '../datasources/auth_exception_mapper.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';
import '../../domain/entities/user_entity.dart';

/// عمليات الدخول والتسجيل — فحص الاتصال قبل أي طلب، والالتقاط هنا فقط (AGENTS-8).
class AuthCredentialsRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final ConnectivityService _connectivity;

  AuthCredentialsRepository({
    required AuthRemoteDataSource authRemoteDataSource,
    required ConnectivityService connectivity,
  }) : _authRemoteDataSource = authRemoteDataSource,
       _connectivity = connectivity;

  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final offline = await offlineFailure(_connectivity);
    if (offline != null) return Left(offline);
    try {
      final userCredential = await _authRemoteDataSource
          .signInWithEmailAndPassword(email: email, password: password);
      final uid = userCredential.user!.uid;

      // Get user data from Firestore
      late final Map<String, dynamic>? userData;
      try {
        userData = await _authRemoteDataSource.getUserFromFirestore(uid);
      } catch (_) {
        return Left(ServerFailure(ErrorStrings.errorGetUserFailed));
      }

      if (userData != null) {
        return Right(UserModel.fromMap(userData).copyWith(uid: uid));
      }

      // If no data in Firestore, create from Firebase Auth
      return Right(UserModel.fromFirebaseUser(userCredential.user));
    } catch (e) {
      final mapped = mapAuthCallError(e);
      return Left(AuthFailure(mapped.message, statusCode: mapped.statusCode));
    }
  }

  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    String? phoneNumber,
    DateTime? dateOfBirth,
  }) async {
    final offline = await offlineFailure(_connectivity);
    if (offline != null) return Left(offline);
    try {
      final userCredential = await _authRemoteDataSource
          .createUserWithEmailAndPassword(email: email, password: password);

      // Save user data to Firestore
      try {
        await _authRemoteDataSource.saveUserToFirestore(
          uid: userCredential.user!.uid,
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          dateOfBirth: dateOfBirth,
        );
      } catch (_) {
        return Left(ServerFailure(ErrorStrings.errorSaveUserFailed));
      }

      return Right(
        UserModel(
          uid: userCredential.user!.uid,
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          dateOfBirth: dateOfBirth,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    } catch (e) {
      final mapped = mapAuthCallError(e);
      return Left(AuthFailure(mapped.message, statusCode: mapped.statusCode));
    }
  }
}
