import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/settings_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';

/// مفتاح "Deep Work Focus" — يُحفظ كتفضيل (FR-031).
class SettingsDeepFocus extends StatelessWidget {
  const SettingsDeepFocus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsCubit, SettingsState, bool>(
      selector: (s) => s.deepFocus,
      builder: (context, deepFocus) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: context.colors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.colors.softBorder),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: context.colors.blueTint,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.bolt_rounded,
                  size: 18,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  SettingsStrings.settingsDeepFocus.tr(),
                style: AppTextStyles.bodySurface.copyWith(
                  color: context.colors.textPrimary,
                ),
                ),
              ),
              Switch(
                value: deepFocus,
                activeThumbColor: AppColors.primary,
                onChanged: context.read<SettingsCubit>().toggleDeepFocus,
              ),
            ],
          ),
        );
      },
    );
  }
}
