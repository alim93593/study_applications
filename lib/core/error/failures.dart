import '../localization/error_strings.dart';

abstract class Failure {
  final String message;
  final int? statusCode;

  Failure(this.message, {this.statusCode});

  @override
  String toString() => message;
}

// Auth Failures — messages are translation keys (displayed via .tr()).
class AuthFailure extends Failure {
  AuthFailure(super.message, {super.statusCode});
}

class EmailAlreadyInUseFailure extends AuthFailure {
  EmailAlreadyInUseFailure()
    : super(ErrorStrings.errorEmailInUse, statusCode: 400);
}

class WrongPasswordFailure extends AuthFailure {
  WrongPasswordFailure() : super(ErrorStrings.errorWrongPassword, statusCode: 401);
}

class UserNotFoundFailure extends AuthFailure {
  UserNotFoundFailure() : super(ErrorStrings.errorUserNotFound, statusCode: 404);
}

class WeakPasswordFailure extends AuthFailure {
  WeakPasswordFailure() : super(ErrorStrings.errorWeakPassword, statusCode: 400);
}

class NetworkFailure extends AuthFailure {
  NetworkFailure() : super(ErrorStrings.errorNetwork, statusCode: 503);
}

class UnknownAuthFailure extends AuthFailure {
  UnknownAuthFailure() : super(ErrorStrings.errorUnknown, statusCode: 500);
}

// Cache Failures
class CacheFailure extends Failure {
  CacheFailure(super.message, {super.statusCode});
}

// Server Failures
class ServerFailure extends Failure {
  ServerFailure(super.message, {super.statusCode});
}

// Validation Failures
class ValidationFailure extends Failure {
  ValidationFailure(super.message, {super.statusCode});
}

// Storage Failures
class StorageFailure extends Failure {
  StorageFailure(super.message, {super.statusCode});
}
