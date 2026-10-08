import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/localization/settings_strings.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_top_bar.dart';
import '../cubit/settings_cubit.dart';
import '../widgets/settings_account_card.dart';
import '../widgets/settings_appearance.dart';
import '../widgets/settings_deep_focus.dart';
import '../widgets/settings_footer.dart';
import '../widgets/settings_rows.dart';

/// شاشة "الإعدادات العامة" (FR-029..032) — thin page تركيب فقط.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SettingsCubit>(),
      child: Scaffold(
        appBar: AppTopBar(title: SettingsStrings.settings.tr(), showBack: true),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                SettingsStrings.settings.tr(),
                style: AppTextStyles.displayMedium.copyWith(
                  color: context.colors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                SettingsStrings.settingsSubtitle.tr(),
                style: AppTextStyles.bodyMutedSurface,
              ),
              const SizedBox(height: 20),
              const SettingsAccountCard(),
              const SizedBox(height: 20),
              const SettingsAppearance(),
              const SizedBox(height: 20),
              const SettingsRows(),
              const SizedBox(height: 20),
              const SettingsDeepFocus(),
              const SizedBox(height: 24),
              const SettingsFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
