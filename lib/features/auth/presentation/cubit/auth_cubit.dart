import 'package:flutter_bloc/flutter_bloc.dart';

export 'auth_state.dart';

import '../../../../core/usecases/base_use_case.dart';
import '../../../../core/utils/logger/app_logger.dart';
import '../../domain/usecases/sign_in_use_case.dart';
import '../../domain/usecases/sign_up_use_case.dart';
import '../../domain/usecases/sign_out_use_case.dart';
import '../../domain/usecases/reset_password_use_case.dart';
import '../../domain/usecases/get_current_user_use_case.dart';
import '../../domain/usecases/get_user_profile_use_case.dart';
import '../../domain/usecases/update_user_profile_use_case.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignOutUseCase _signOutUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final GetUserProfileUseCase _getUserProfileUseCase;
  final UpdateUserProfileUseCase _updateUserProfileUseCase;

  AuthCubit({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    required SignOutUseCase signOutUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required GetUserProfileUseCase getUserProfileUseCase,
    required UpdateUserProfileUseCase updateUserProfileUseCase,
  })  : _signInUseCase = signInUseCase,
        _signUpUseCase = signUpUseCase,
        _signOutUseCase = signOutUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase,
        _getUserProfileUseCase = getUserProfileUseCase,
        _updateUserProfileUseCase = updateUserProfileUseCase,
        super(const AuthState());

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));
    AppLogger.i('Attempting sign in for: $email');
    final result = await _signInUseCase(
      SignInParams(email: email, password: password),
    );
    result.fold(
      (failure) {
        AppLogger.e('Sign in failed: ${failure.message}');
        emit(
          state.copyWith(
            status: AuthStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (user) {
        AppLogger.i('Sign in successful for: ${user.email}');
        emit(
          state.copyWith(status: AuthStatus.authenticated, user: user),
        );
      },
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    String? phoneNumber,
    DateTime? dateOfBirth,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));
    AppLogger.i('Attempting sign up for: $email');
    final result = await _signUpUseCase(
      SignUpParams(
        email: email,
        password: password,
        name: name,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
      ),
    );
    result.fold(
      (failure) {
        AppLogger.e('Sign up failed: ${failure.message}');
        emit(
          state.copyWith(
            status: AuthStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (user) {
        AppLogger.i('Sign up successful for: ${user.email}');
        emit(
          state.copyWith(status: AuthStatus.authenticated, user: user),
        );
      },
    );
  }

  Future<void> signOut() async {
    emit(state.copyWith(status: AuthStatus.loading));
    AppLogger.i('Signing out');
    final result = await _signOutUseCase(const SignOutParams());
    result.fold(
      (failure) {
        AppLogger.e('Sign out failed: ${failure.message}');
        emit(
          state.copyWith(
            status: AuthStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (_) {
        AppLogger.i('Sign out successful');
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      },
    );
  }

  Future<void> resetPassword(String email) async {
    emit(state.copyWith(status: AuthStatus.loading));
    AppLogger.i('Resetting password for: $email');
    final result = await _resetPasswordUseCase(
      ResetPasswordParams(email: email),
    );
    result.fold(
      (failure) {
        AppLogger.e('Password reset failed: ${failure.message}');
        emit(
          state.copyWith(
            status: AuthStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (_) {
        AppLogger.i('Password reset email sent');
        emit(
          state.copyWith(
            status: AuthStatus.passwordResetSent,
            email: email,
          ),
        );
      },
    );
  }

  Future<void> checkAuthStatus() async {
    AppLogger.i('Checking auth status...');
    final result = await _getCurrentUserUseCase(const NoParams());
    result.fold(
      (failure) {
        AppLogger.w('Auth check failed: ${failure.message}');
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      },
      (user) {
        if (user != null) {
          AppLogger.i('User found: ${user.email}');
          emit(
            state.copyWith(status: AuthStatus.authenticated, user: user),
          );
        } else {
          AppLogger.w('No user found');
          emit(state.copyWith(status: AuthStatus.unauthenticated));
        }
      },
    );
  }

  Future<void> getUserProfile(String uid) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _getUserProfileUseCase(
      GetUserProfileParams(uid: uid),
    );
    result.fold(
      (failure) {
        AppLogger.e('Get profile failed: ${failure.message}');
        emit(
          state.copyWith(
            status: AuthStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (user) => emit(
        state.copyWith(status: AuthStatus.authenticated, user: user),
      ),
    );
  }

  Future<void> updateUserProfile({
    required String uid,
    String? name,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? photoURL,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));
    AppLogger.i('Updating profile for uid: $uid');
    final result = await _updateUserProfileUseCase(
      UpdateUserProfileParams(
        uid: uid,
        name: name,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        photoURL: photoURL,
      ),
    );
    result.fold(
      (failure) {
        AppLogger.e('Profile update failed: ${failure.message}');
        emit(
          state.copyWith(
            status: AuthStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (_) async {
        final profileResult = await _getUserProfileUseCase(
          GetUserProfileParams(uid: uid),
        );
        profileResult.fold(
          (failure) {
            AppLogger.e('Fetch updated profile failed: ${failure.message}');
            emit(
              state.copyWith(
                status: AuthStatus.error,
                errorMessage: failure.message,
              ),
            );
          },
          (user) {
            AppLogger.i('Profile updated successfully');
            emit(
              state.copyWith(
                status: AuthStatus.profileUpdated,
                user: user,
              ),
            );
          },
        );
      },
    );
  }
}
