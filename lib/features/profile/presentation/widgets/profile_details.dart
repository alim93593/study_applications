import 'package:flutter/material.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/domain/entities/user_entity.dart';
import 'profile_avatar.dart';
import 'profile_edit_button.dart';
import 'profile_info_card.dart';

/// Full profile content — every value arrives display-ready from AuthState,
/// this widget only renders it (Zero UI Logic).
class ProfileDetails extends StatelessWidget {
  const ProfileDetails({
    super.key,
    required this.user,
    required this.name,
    required this.phone,
    required this.dob,
  });

  final UserEntity user;
  final String name;
  final String phone;
  final String dob;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ProfileAvatar(photoURL: user.photoURL),
          const SizedBox(height: 16),
          Text(name, style: AppTextStyles.headlineMedium),
          const SizedBox(height: 8),
          Text(user.email, style: AppTextStyles.bodyGlass),
          const SizedBox(height: 24),
          ProfileInfoCard(
            icon: Icons.person,
            titleKey: AppStrings.name,
            value: name,
          ),
          const SizedBox(height: 12),
          ProfileInfoCard(
            icon: Icons.email,
            titleKey: AppStrings.email,
            value: user.email,
          ),
          const SizedBox(height: 12),
          ProfileInfoCard(
            icon: Icons.phone,
            titleKey: AppStrings.phone,
            value: phone,
          ),
          const SizedBox(height: 12),
          ProfileInfoCard(
            icon: Icons.cake,
            titleKey: AppStrings.dateOfBirth,
            value: dob,
          ),
          const SizedBox(height: 24),
          ProfileEditButton(
            onTap: () => AppNavigator.push(AppNavigator.editProfile),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
