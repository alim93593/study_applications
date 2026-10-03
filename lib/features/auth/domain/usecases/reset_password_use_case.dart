import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../repositories/auth_repository.dart';

class ResetPasswordParams extends Equatable {
  final String email;

  const ResetPasswordParams({required this.email});

  @override
  List<Object?> get props => [email];
}

class ResetPasswordUseCase extends UseCase<void, ResetPasswordParams> {
  final AuthRepository _authRepository;

  ResetPasswordUseCase(this._authRepository);

  @override
  Future<Either<Failure, void>> call(ResetPasswordParams params) async {
    return await _authRepository.resetPassword(params.email);
  }
}
