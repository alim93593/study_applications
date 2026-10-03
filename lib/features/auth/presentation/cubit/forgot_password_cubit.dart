import 'package:flutter_bloc/flutter_bloc.dart';

export 'forgot_password_state.dart';

import '../../../../core/utils/logger/app_logger.dart';
import '../../domain/usecases/reset_password_use_case.dart';
import 'forgot_password_state.dart';

/// Screen-scoped cubit for the forgot-password flow — registered per screen,
/// not in main.dart (AGENTS: UI cubits live at screen level).
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ResetPasswordUseCase _resetPasswordUseCase;

  ForgotPasswordCubit({required ResetPasswordUseCase resetPasswordUseCase})
    : _resetPasswordUseCase = resetPasswordUseCase,
      super(const ForgotPasswordState());

  Future<void> sendResetEmail(String email) async {
    emit(state.copyWith(status: ForgotPasswordStatus.loading));
    final value = email.trim();
    AppLogger.i('Sending password reset email to: $value');
    final result = await _resetPasswordUseCase(
      ResetPasswordParams(email: value),
    );
    result.fold(
      (failure) {
        AppLogger.e('Password reset failed: ${failure.message}');
        emit(
          state.copyWith(
            status: ForgotPasswordStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (_) {
        AppLogger.i('Password reset email sent');
        emit(state.copyWith(status: ForgotPasswordStatus.sent));
      },
    );
  }
}
