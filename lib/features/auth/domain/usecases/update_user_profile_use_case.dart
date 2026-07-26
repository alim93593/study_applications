import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../repositories/auth_repository.dart';

class UpdateUserProfileParams extends Equatable {
  final String uid;
  final String? name;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String? photoURL;

  const UpdateUserProfileParams({
    required this.uid,
    this.name,
    this.phoneNumber,
    this.dateOfBirth,
    this.photoURL,
  });

  @override
  List<Object?> get props => [uid, name, phoneNumber, dateOfBirth, photoURL];
}

class UpdateUserProfileUseCase extends UseCase<void, UpdateUserProfileParams> {
  final AuthRepository _authRepository;

  UpdateUserProfileUseCase(this._authRepository);

  @override
  Future<Either<Failure, void>> call(UpdateUserProfileParams params) async {
    return await _authRepository.updateUserProfile(
      uid: params.uid,
      name: params.name,
      phoneNumber: params.phoneNumber,
      dateOfBirth: params.dateOfBirth,
      photoURL: params.photoURL,
    );
  }
}