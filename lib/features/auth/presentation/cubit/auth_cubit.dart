import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'auth_state.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/base_use_case.dart';
import '../../../../core/utils/logger/app_logger.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_current_user_use_case.dart';
import '../../domain/usecases/sign_in_use_case.dart';
import '../../domain/usecases/sign_out_use_case.dart';
import '../../domain/usecases/sign_up_use_case.dart';
import 'auth_state.dart';

/// Session-only cubit; profile edits live in ProfileCubit.
class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.getCurrentUserUseCase,
  }) : super(const AuthState());

  Future<void> signIn({required String email, required String password}) async {
    await _run(
      signInUseCase(SignInParams(email: email, password: password)),
      'Sign in',
      _authenticated,
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    String? phoneNumber,
    DateTime? dateOfBirth,
  }) async {
    final params = SignUpParams(
      email: email,
      password: password,
      name: name,
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
    );
    await _run(signUpUseCase(params), 'Sign up', _authenticated);
  }

  Future<void> signOut() async {
    await _run(
      signOutUseCase(const SignOutParams()),
      'Sign out',
      (_) => _unauthenticated(),
    );
  }

  Future<void> checkAuthStatus() async {
    final result = await getCurrentUserUseCase(const NoParams());
    result.fold(
      (failure) => _unauthenticated('Auth check failed: ${failure.message}'),
      (user) => user != null ? _authenticated(user) : _unauthenticated(),
    );
  }

  /// Re-seeds the cached session profile after ProfileCubit saves edits.
  void hydrateUser(UserEntity user) => emit(state.copyWith(user: user));

  void _authenticated(UserEntity user) =>
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));

  void _unauthenticated([String? reason]) {
    if (reason != null) AppLogger.w(reason);
    emit(state.copyWith(status: AuthStatus.unauthenticated));
  }

  // Emits loading, folds the result; the failure is logged with its action
  // context, while the emitted message stays a pure translation key for .tr().
  Future<void> _run<T>(
    Future<Either<Failure, T>> result,
    String action,
    void Function(T data) onSuccess,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final outcome = await result;
    outcome.fold(
      (failure) {
        AppLogger.e('$action failed: ${failure.message}');
        emit(
          state.copyWith(
            status: AuthStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      onSuccess,
    );
  }
}
