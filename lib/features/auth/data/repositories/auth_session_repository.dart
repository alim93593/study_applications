import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/localization/error_strings.dart';
import '../../../../core/network/offline_guard.dart';
import '../../../../core/services/connectivity_service.dart';
import '../datasources/auth_exception_mapper.dart';
import '../datasources/auth_remote_data_source.dart';

/// عمليات الجلسة (خروج + استعادة كلمة المرور).
/// Why: استخرجناها من AuthRepositoryImpl عشان يفضل تحت 100 سطر.
/// signOut عملية محلية — لا تُحجب بالأوفلاين أبدًا (وإلا عُلق المستخدم).
/// الالتقاط هنا فقط (AGENTS-8).
class AuthSessionRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final ConnectivityService _connectivity;

  AuthSessionRepository({
    required AuthRemoteDataSource authRemoteDataSource,
    required ConnectivityService connectivity,
  }) : _authRemoteDataSource = authRemoteDataSource,
       _connectivity = connectivity;

  Future<Either<Failure, void>> signOut() async {
    try {
      await _authRemoteDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(ErrorStrings.errorSignOutFailed));
    }
  }

  Future<Either<Failure, void>> resetPassword(String email) async {
    final offline = await offlineFailure(_connectivity);
    if (offline != null) return Left(offline);
    try {
      await _authRemoteDataSource.resetPassword(email);
      return const Right(null);
    } catch (e) {
      final mapped = mapAuthCallError(
        e,
        fallbackKey: ErrorStrings.errorResetPasswordFailed,
      );
      return Left(AuthFailure(mapped.message, statusCode: mapped.statusCode));
    }
  }
}
