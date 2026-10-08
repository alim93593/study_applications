import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/localization/error_strings.dart';
import '../../../../core/network/offline_guard.dart';
import '../../../../core/services/connectivity_service.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';
import '../../domain/entities/user_entity.dart';

/// عمليات قراءة/تحديث ملف المستخدم — فحص الاتصال قبل أي طلب (AGENTS-8).
class AuthUserProfileRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final ConnectivityService _connectivity;

  AuthUserProfileRepository({
    required AuthRemoteDataSource authRemoteDataSource,
    required ConnectivityService connectivity,
  }) : _authRemoteDataSource = authRemoteDataSource,
       _connectivity = connectivity;

  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final firebaseUser = _authRemoteDataSource.currentUser;
      if (firebaseUser == null) return const Right(null);
      // Offline: keep the cached session without sending any request.
      if (!await _connectivity.isConnected) {
        return Right(UserModel.fromFirebaseUser(firebaseUser));
      }
      final userData = await _authRemoteDataSource.getUserFromFirestore(
        firebaseUser.uid,
      );

      if (userData != null) {
        final user = UserModel.fromMap(
          userData,
        ).copyWith(uid: firebaseUser.uid);
        return Right(user);
      }

      // If no data in Firestore, create from Firebase Auth
      return Right(UserModel.fromFirebaseUser(firebaseUser));
    } catch (e) {
      return Left(AuthFailure(ErrorStrings.errorGetCurrentUserFailed));
    }
  }

  Future<Either<Failure, UserEntity>> getUserProfile(String uid) async {
    final offline = await offlineFailure(_connectivity);
    if (offline != null) return Left(offline);
    try {
      final userData = await _authRemoteDataSource.getUserFromFirestore(uid);

      if (userData != null) {
        final user = UserModel.fromMap(userData).copyWith(uid: uid);
        return Right(user);
      }

      return Left(AuthFailure(ErrorStrings.errorUserNotFound));
    } catch (e) {
      return Left(AuthFailure(ErrorStrings.errorGetProfileFailed));
    }
  }

  Future<Either<Failure, void>> updateUserProfile({
    required String uid,
    String? name,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? photoURL,
  }) async {
    final offline = await offlineFailure(_connectivity);
    if (offline != null) return Left(offline);
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
      return Left(AuthFailure(ErrorStrings.errorUpdateProfileFailed));
    }
  }
}
