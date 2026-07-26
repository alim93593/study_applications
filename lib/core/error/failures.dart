abstract class Failure {
  final String message;
  final int? statusCode;
  
  Failure(this.message, {this.statusCode});
  
  @override
  String toString() => message;
}

// Auth Failures
class AuthFailure extends Failure {
  AuthFailure(super.message, {super.statusCode});
}

class EmailAlreadyInUseFailure extends AuthFailure {
  EmailAlreadyInUseFailure() : super('Email already in use', statusCode: 400);
}

class WrongPasswordFailure extends AuthFailure {
  WrongPasswordFailure() : super('Wrong password', statusCode: 401);
}

class UserNotFoundFailure extends AuthFailure {
  UserNotFoundFailure() : super('User not found', statusCode: 404);
}

class WeakPasswordFailure extends AuthFailure {
  WeakPasswordFailure() : super('Password is too weak', statusCode: 400);
}

class NetworkFailure extends AuthFailure {
  NetworkFailure() : super('Network error occurred', statusCode: 503);
}

class UnknownAuthFailure extends AuthFailure {
  UnknownAuthFailure() : super('An unknown error occurred', statusCode: 500);
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