import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_for_ever/core/error/failures.dart';
import 'package:study_for_ever/features/auth/domain/repositories/auth_repository.dart';
import 'package:study_for_ever/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:study_for_ever/features/auth/presentation/cubit/forgot_password_cubit.dart';

/// noSuchMethod forwarding keeps the fake short without a mock package.
class _UnusedRepo implements AuthRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class _FakeResetPasswordUseCase extends ResetPasswordUseCase {
  _FakeResetPasswordUseCase(this.result) : super(_UnusedRepo());

  final Either<Failure, void> result;
  ResetPasswordParams? lastParams;

  @override
  Future<Either<Failure, void>> call(ResetPasswordParams params) async {
    lastParams = params;
    return result;
  }
}

void main() {
  group('ForgotPasswordCubit', () {
    test('emits sent and trims the email on success', () async {
      final useCase = _FakeResetPasswordUseCase(const Right(null));
      final cubit = ForgotPasswordCubit(resetPasswordUseCase: useCase);

      await cubit.sendResetEmail('  user@test.com  ');

      expect(cubit.state.status, ForgotPasswordStatus.sent);
      expect(useCase.lastParams?.email, 'user@test.com');
    });

    test('emits error with the failure message', () async {
      final useCase = _FakeResetPasswordUseCase(
        Left(AuthFailure('reset failed')),
      );
      final cubit = ForgotPasswordCubit(resetPasswordUseCase: useCase);

      await cubit.sendResetEmail('user@test.com');

      expect(cubit.state.status, ForgotPasswordStatus.error);
      expect(cubit.state.errorMessage, 'reset failed');
    });
  });
}
