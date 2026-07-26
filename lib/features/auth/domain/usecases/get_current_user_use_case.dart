import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUserUseCase extends UseCase<UserEntity?, NoParams> {
  final AuthRepository _authRepository;

  GetCurrentUserUseCase(this._authRepository);

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) {
    return _authRepository.getCurrentUser();
  }
}
