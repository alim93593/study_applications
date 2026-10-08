import '../localization/error_strings.dart';

class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({required this.message, this.statusCode});

  @override
  String toString() => 'ServerException: $message (Status: $statusCode)';
}

class CacheException implements Exception {
  final String message;

  CacheException({required this.message});

  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception {
  final String message;

  NetworkException({required this.message});

  @override
  String toString() => 'NetworkException: $message';
}

class ValidationException implements Exception {
  final String message;

  ValidationException({required this.message});

  @override
  String toString() => 'ValidationException: $message';
}

// Auth Exceptions — messages are translation keys (displayed via .tr()).
class AuthException implements Exception {
  final String message;
  final int? statusCode;

  AuthException({required this.message, this.statusCode});

  @override
  String toString() => 'AuthException: $message (Status: $statusCode)';
}

class EmailAlreadyInUseException extends AuthException {
  EmailAlreadyInUseException()
    : super(message: ErrorStrings.errorEmailInUse, statusCode: 400);
}

class WrongPasswordException extends AuthException {
  WrongPasswordException()
    : super(message: ErrorStrings.errorWrongPassword, statusCode: 401);
}

class UserNotFoundException extends AuthException {
  UserNotFoundException()
    : super(message: ErrorStrings.errorUserNotFound, statusCode: 404);
}

class WeakPasswordException extends AuthException {
  WeakPasswordException()
    : super(message: ErrorStrings.errorWeakPassword, statusCode: 400);
}

class NetworkException2 extends AuthException {
  NetworkException2() : super(message: ErrorStrings.errorNetwork, statusCode: 503);
}

class UnknownAuthException extends AuthException {
  UnknownAuthException()
    : super(message: ErrorStrings.errorUnknown, statusCode: 500);
}

// Storage Exceptions
class StorageException implements Exception {
  final String message;

  StorageException({required this.message});

  @override
  String toString() => 'StorageException: $message';
}
