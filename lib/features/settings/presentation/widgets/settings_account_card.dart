import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';

/// بطاقة الحساب في الإعدادات (FR-029): الصورة والاسم والبريد وإجراء تغيير
/// الصورة (يفتح شاشة الملف الشخصي حيث يقع مسار تعديل الصورة).
class SettingsAccountCard extends StatelessWidget {
  const SettingsAccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthCubit, AuthState, (String, String)>(
      selector: (s) => (s.user?.name ?? '', s.user?.email ?? ''),
      builder: (context, data) {
        final (name, email) = data;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.colors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.colors.softBorder),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: context.colors.blueTint,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      size: 30,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: AppTextStyles.titleSmall.copyWith(
                            color: context.colors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          email,
                          style: AppTextStyles.labelSurface.copyWith(
                            color: context.colors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
