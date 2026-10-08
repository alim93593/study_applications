import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';

/// Welcome card — the greeting name is selected from AuthState in the
/// selector, never computed here. Light surface card (Focus screen redesign).
class HomeWelcomeCard extends StatelessWidget {
  const HomeWelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthCubit, AuthState, String>(
      selector: (state) => state.user?.name.split(' ').first ?? '',
      builder: (context, userName) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: context.colors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: context.colors.softBorder),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: context.colors.blueTint,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.waving_hand,
                  size: 30,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: AppTextStyles.titleSurface.copyWith(
                        color: context.colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.readyToLearn.tr(),
                      style: AppTextStyles.bodyMutedSurface.copyWith(
                        color: context.colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
