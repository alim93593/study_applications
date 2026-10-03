import 'package:equatable/equatable.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/utils/formatters/app_date_formatter.dart';
import '../../domain/entities/user_entity.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
  passwordResetSent,
  profileUpdated,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final UserEntity? user;
  final String? errorMessage;
  final String? email;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
    this.email,
  });

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user,
    String? errorMessage,
    String? email,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
    );
  }

  // Display-ready values: the UI reads them as-is (Zero UI Logic rule).
  String get phoneDisplay {
    final phone = user?.phoneNumber;
    if (phone == null || phone.trim().isEmpty) {
      return AppStrings.notProvided.tr();
    }
    return phone;
  }

  String get dobDisplay {
    final dob = user?.dateOfBirth;
    if (dob == null) return AppStrings.notProvided.tr();
    return AppDateFormatter.dob(dob);
  }

  @override
  List<Object?> get props => [status, user, errorMessage, email];
}
