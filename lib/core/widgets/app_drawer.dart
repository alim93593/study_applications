import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../localization/app_strings.dart';
import '../localization/settings_strings.dart';
import '../navigator/app_navigator.dart';
import '../router/app_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_colors_extension.dart';
import '../theme/app_text_styles.dart';

/// الدرج الجانبي (قائمة ☰) — وصول للملف الشخصي والإعدادات واللغة والإحصائيات.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  static const List<(IconData, String, String)> _items = [
    (Icons.person_outline_rounded, AppStrings.profile, AppRouter.profile),
    (Icons.bar_chart_rounded, AppStrings.statistics, AppRouter.stats),
    (Icons.settings_outlined, SettingsStrings.settings, AppRouter.setting),
    (Icons.translate_rounded, AppStrings.language, AppRouter.language),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.colors.background,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                AppStrings.appName.tr(),
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
            Divider(color: context.colors.softBorder),
            for (final item in _items)
              ListTile(
                leading: Icon(item.$1, color: AppColors.primary),
                title: Text(
                  item.$2.tr(),
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: context.colors.textPrimary,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  if (item.$3 == AppRouter.stats) {
                    AppNavigator.pushReplacement(AppRouter.shell, arguments: 3);
                  } else {
                    AppNavigator.push(item.$3);
                  }
                },
              ),
            const Spacer(),
            Divider(color: context.colors.softBorder),
            ListTile(
              leading: const Icon(Icons.logout_rounded, color: AppColors.error),
              title: Text(
                AppStrings.logout.tr(),
                style: AppTextStyles.bodyLarge.copyWith(
                  color: context.colors.textPrimary,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                context.read<AuthCubit>().signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
