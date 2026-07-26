import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.name,
    required super.email,
    super.phoneNumber,
    super.dateOfBirth,
    super.photoURL,
    super.createdAt,
    super.updatedAt,
  });

  factory UserModel.fromFirebaseUser(dynamic firebaseUser) {
    return UserModel(
      uid: firebaseUser.uid,
      name: firebaseUser.displayName ?? '',
      email: firebaseUser.email ?? '',
      phoneNumber: firebaseUser.phoneNumber,
      dateOfBirth: null,
      photoURL: firebaseUser.photoURL,
      createdAt: firebaseUser.metadata.creationTime,
      updatedAt: firebaseUser.metadata.lastSignInTime,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'],
      dateOfBirth: map['dateOfBirth']?.toDate(),
      photoURL: map['photoURL'],
      createdAt: map['createdAt']?.toDate(),
      updatedAt: map['updatedAt']?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'photoURL': photoURL,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? photoURL,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
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
