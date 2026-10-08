import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/localization/settings_strings.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/widget/glass_button.dart';
import '../../../../core/widgets/app_top_bar.dart';
import '../cubit/language_cubit.dart';
import '../cubit/language_state.dart';
import '../widgets/language_options.dart';
import '../widgets/language_preferences.dart';

/// شاشة "إعدادات اللغة" (FR-033..035) — thin page؛ منطق الاختيار والحفظ
/// في LanguageCubit وتطبيق اللغة عبر BlocListener.
class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Why: reading the locale here (inside build — listening is legal) keeps
    // BlocProvider.create context-free; any InheritedWidget read inside
    // `create` throws "Tried to listen ... in a life-cycle that will never be
    // called again" (Provider) and crashed this screen before.
    final initialLanguage =
        Localizations.maybeLocaleOf(context)?.languageCode ?? 'ar';
    return BlocProvider(
      create: (_) => sl<LanguageCubit>()..selectLanguage(initialLanguage),
      child: BlocListener<LanguageCubit, LanguageState>(
        listenWhen: (prev, curr) => curr.applyToken != prev.applyToken,
        listener: (ctx, state) => ctx.setLocale(Locale(state.selectedLanguage)),
        // Builder ضروري: زر Apply بيقرأ الكيوبت من context تحت الـ
        // BlocProvider — قراءة الـ build context بتطلع فوقه فيش Provider.
        child: Builder(
          builder: (inner) => Scaffold(
            appBar: AppTopBar(
              title: SettingsStrings.languageTitle.tr(),
              showBack: true,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    SettingsStrings.languageTitle.tr(),
                    style: AppTextStyles.displayMedium.copyWith(
                      color: context.colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    SettingsStrings.languageSubtitle.tr(),
                    style: AppTextStyles.bodyMutedSurface,
                  ),
                  const SizedBox(height: 24),
                  const LanguageOptions(),
                  const SizedBox(height: 20),
                  const LanguagePreferences(),
                  const SizedBox(height: 28),
                  GlassButton(
                    text: SettingsStrings.languageApply.tr(),
                    icon: Icons.check_rounded,
                    onPressed: () =>
                        inner.read<LanguageCubit>().applyLanguage(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
