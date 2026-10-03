import 'package:equatable/equatable.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/utils/formatters/app_date_formatter.dart';
import '../../../auth/domain/entities/user_entity.dart';

enum ProfileStatus { initial, loading, saved, error }

/// Display strings are prepared here (state layer) so the widgets only
/// render them — Zero UI Logic rule.
class ProfileState extends Equatable {
  final ProfileStatus status;
  final String? errorMessage;
  final String uid;
  final String name;
  final String phone;
  final DateTime? dateOfBirth;
  final String dateDisplay;
  final UserEntity? updatedUser;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.errorMessage,
    this.uid = '',
    this.name = '',
    this.phone = '',
    this.dateOfBirth,
    this.dateDisplay = '',
    this.updatedUser,
  });

  bool get hasDate => dateOfBirth != null;

  factory ProfileState.fromUser(UserEntity? user) {
    final dob = user?.dateOfBirth;
    return ProfileState(
      uid: user?.uid ?? '',
      name: user?.name ?? '',
      phone: user?.phoneNumber ?? '',
      dateOfBirth: dob,
      dateDisplay: dob != null
          ? AppDateFormatter.dob(dob)
          : AppStrings.selectDateOfBirth.tr(),
      updatedUser: user,
    );
  }

  ProfileState copyWith({
    ProfileStatus? status,
    String? errorMessage,
    String? uid,
    String? name,
    String? phone,
    DateTime? dateOfBirth,
    String? dateDisplay,
    UserEntity? updatedUser,
  }) {
    return ProfileState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      dateDisplay: dateDisplay ?? this.dateDisplay,
      updatedUser: updatedUser ?? this.updatedUser,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    uid,
    name,
    phone,
    dateOfBirth,
    dateDisplay,
    updatedUser,
  ];
}
