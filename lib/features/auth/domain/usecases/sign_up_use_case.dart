import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpParams extends Equatable {
  final String email;
  final String password;
  final String name;
  final String? phoneNumber;
  final DateTime? dateOfBirth;

  const SignUpParams({
    required this.email,
    required this.password,
    required this.name,
    this.phoneNumber,
    this.dateOfBirth,
  });

  @override
  List<Object?> get props => [email, password, name, phoneNumber, dateOfBirth];
}

class SignUpUseCase extends UseCase<UserEntity, SignUpParams> {
  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) async {
    return await _authRepository.signUpWithEmailAndPassword(
      email: params.email,
      password: params.password,
      name: params.name,
      phoneNumber: params.phoneNumber,
      dateOfBirth: params.dateOfBirth,
    );
  }
}
