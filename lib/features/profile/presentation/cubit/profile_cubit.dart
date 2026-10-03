import 'package:flutter_bloc/flutter_bloc.dart';

export 'profile_state.dart';

import '../../../../core/utils/formatters/app_date_formatter.dart';
import '../../../../core/utils/logger/app_logger.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/domain/usecases/get_user_profile_use_case.dart';
import '../../../auth/domain/usecases/update_user_profile_use_case.dart';
import 'profile_state.dart';

/// Owns the profile editing flow (seed → pick date → save → refresh) so the
/// view never formats dates or builds request payloads itself.
class ProfileCubit extends Cubit<ProfileState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final UpdateUserProfileUseCase _updateUserProfileUseCase;

  ProfileCubit({
    required GetUserProfileUseCase getUserProfileUseCase,
    required UpdateUserProfileUseCase updateUserProfileUseCase,
  }) : _getUserProfileUseCase = getUserProfileUseCase,
       _updateUserProfileUseCase = updateUserProfileUseCase,
       super(const ProfileState());

  /// Seeds the form from the cached session profile at screen scope.
  void seed(UserEntity? user) => emit(ProfileState.fromUser(user));

  void selectDate(DateTime date) => emit(
    state.copyWith(dateOfBirth: date, dateDisplay: AppDateFormatter.dob(date)),
  );

  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final phoneValue = phone.trim();
    final result = await _updateUserProfileUseCase(
      UpdateUserProfileParams(
        uid: state.uid,
        name: name.trim(),
        phoneNumber: phoneValue.isEmpty ? null : phoneValue,
        dateOfBirth: state.dateOfBirth,
      ),
    );
    result.fold((failure) {
      AppLogger.e('Profile update failed: ${failure.message}');
      emit(
        state.copyWith(
          status: ProfileStatus.error,
          errorMessage: failure.message,
        ),
      );
    }, (_) => _refreshProfile());
  }

  // Re-reads the profile after a save so the screen closes with server-fresh
  // values instead of trusting the local payload.
  Future<void> _refreshProfile() async {
    final result = await _getUserProfileUseCase(
      GetUserProfileParams(uid: state.uid),
    );
    result.fold(
      (failure) {
        AppLogger.e('Fetch updated profile failed: ${failure.message}');
        emit(
          state.copyWith(
            status: ProfileStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (user) {
        AppLogger.i('Profile updated successfully');
        emit(ProfileState.fromUser(user).copyWith(status: ProfileStatus.saved));
      },
    );
  }
}
