import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../repositories/auth_repository.dart';

class SignOutParams extends Equatable {
  const SignOutParams();

  @override
  List<Object?> get props => [];
}

class SignOutUseCase extends UseCase<void, SignOutParams> {
  final AuthRepository _authRepository;

  SignOutUseCase(this._authRepository);

  @override
  Future<Either<Failure, void>> call(SignOutParams params) async {
    return await _authRepository.signOut();
  }
}
