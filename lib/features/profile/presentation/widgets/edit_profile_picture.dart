import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';

/// صورة الملف الشخصي (بلا أيقونة تغيير الصورة — الرفع غير مدعوم في التطبيق).
class EditProfilePicture extends StatelessWidget {
  const EditProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: context.colors.blueTint,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: context.colors.softBorder, width: 2),
      ),
      child: const Icon(Icons.person, size: 60, color: AppColors.primary),
    );
  }
}
