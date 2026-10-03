import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Profile avatar with fallback icon when no photo is set.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, required this.photoURL});

  final String? photoURL;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.glassWhite,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.glassBorder, width: 2),
      ),
      child: photoURL != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(photoURL!, fit: BoxFit.cover),
            )
          : const Icon(Icons.person, size: 60, color: Colors.white),
    );
  }
}
