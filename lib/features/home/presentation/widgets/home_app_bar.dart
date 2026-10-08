import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/app_strings.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'home_logout_dialog.dart';

/// Home app bar with profile + logout actions.
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.appName.tr(),
            style: AppTextStyles.titleSurface.copyWith(
              color: context.colors.textPrimary,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _IconButton(
                icon: Icons.person,
                onPressed: () => AppNavigator.push(AppNavigator.profile),
              ),
              const SizedBox(width: 8),
              _IconButton(
                icon: Icons.logout,
                onPressed: () => showLogoutDialog(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: context.colors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.softBorder),
      ),
      child: IconButton(
        icon: Icon(icon, color: context.colors.textPrimary, size: 24),
        onPressed: onPressed,
      ),
    );
  }
}
