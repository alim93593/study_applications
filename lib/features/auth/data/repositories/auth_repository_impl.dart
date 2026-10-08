import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/services/connectivity_service.dart';
import '../datasources/auth_remote_data_source.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_credentials_repository.dart';
import 'auth_profile_repository.dart';
import 'auth_session_repository.dart';

/// Orchestrator فوق ثلاث مجموعات مساعدة (Credentials + UserProfile + Session).
/// Why: تقسيم الملف الأصلي (182 سطر) لقاعدة 100 سطر — نفس السلوك حرفيًا.
class AuthRepositoryImpl implements AuthRepository {
  final AuthCredentialsRepository _credentials;
  final AuthUserProfileRepository _profile;
  final AuthSessionRepository _session;

  AuthRepositoryImpl({
    required AuthRemoteDataSource authRemoteDataSource,
    required ConnectivityService connectivity,
  }) : _credentials = AuthCredentialsRepository(
         authRemoteDataSource: authRemoteDataSource,
         connectivity: connectivity,
       ),
       _profile = AuthUserProfileRepository(
         authRemoteDataSource: authRemoteDataSource,
         connectivity: connectivity,
       ),
       _session = AuthSessionRepository(
         authRemoteDataSource: authRemoteDataSource,
         connectivity: connectivity,
       );

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      _credentials.signInWithEmailAndPassword(email: email, password: password);

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    String? phoneNumber,
    DateTime? dateOfBirth,
  }) => _credentials.signUpWithEmailAndPassword(
    email: email,
    password: password,
    name: name,
    phoneNumber: phoneNumber,
    dateOfBirth: dateOfBirth,
  );

  @override
  Future<Either<Failure, void>> signOut() => _session.signOut();

  @override
  Future<Either<Failure, void>> resetPassword(String email) =>
      _session.resetPassword(email);

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() =>
      _profile.getCurrentUser();

  @override
  Future<Either<Failure, UserEntity>> getUserProfile(String uid) =>
      _profile.getUserProfile(uid);

  @override
  Future<Either<Failure, void>> updateUserProfile({
    required String uid,
    String? name,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? photoURL,
  }) => _profile.updateUserProfile(
    uid: uid,
    name: name,
    phoneNumber: phoneNumber,
    dateOfBirth: dateOfBirth,
    photoURL: photoURL,
  );
}
