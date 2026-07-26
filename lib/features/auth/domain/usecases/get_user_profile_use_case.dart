import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetUserProfileParams extends Equatable {
  final String uid;

  const GetUserProfileParams({required this.uid});

  @override
  List<Object?> get props => [uid];
}

class GetUserProfileUseCase extends UseCase<UserEntity, GetUserProfileParams> {
  final AuthRepository _authRepository;

  GetUserProfileUseCase(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(GetUserProfileParams params) async {
    return await _authRepository.getUserProfile(params.uid);
  }
}