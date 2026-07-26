import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignInParams extends Equatable {
  final String email;
  final String password;

  const SignInParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignInUseCase extends UseCase<UserEntity, SignInParams> {
  final AuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(SignInParams params) async {
    return await _authRepository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}