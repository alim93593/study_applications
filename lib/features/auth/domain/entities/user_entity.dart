import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String? photoURL;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.photoURL,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        phoneNumber,
        dateOfBirth,
        photoURL,
        createdAt,
        updatedAt,
      ];

  UserEntity copyWith({
    String? uid,
    String? name,
    String? email,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? photoURL,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      photoURL: photoURL ?? this.photoURL,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}