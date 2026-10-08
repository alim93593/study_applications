import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../localization/app_strings.dart';
import '../navigator/app_navigator.dart';
import '../router/app_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// الشريط العلوي الموحد كما في تصاميم Figma (قائمة / عنوان / مبدّل اللغة).
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showClose;
  final bool showBack;
  final VoidCallback? onClose;

  const AppTopBar({
    super.key,
    this.title,
    this.showClose = false,
    this.showBack = false,
    this.onClose,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SizedBox(
        height: 64,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              if (showClose)
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  color: AppColors.primary,
                  onPressed: onClose ?? AppNavigator.pop,
                )
              else if (showBack)
                IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  color: AppColors.primary,
                  onPressed: onClose ?? AppNavigator.pop,
                )
              else
                Builder(
                  builder: (barContext) => IconButton(
                    icon: const Icon(Icons.menu_rounded),
                    color: AppColors.primary,
                    onPressed: () => Scaffold.of(barContext).openDrawer(),
                  ),
                ),
              Expanded(
                child: Text(
                  title ?? AppStrings.appName.tr(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.translate_rounded),
                color: AppColors.primary,
                onPressed: () => AppNavigator.push(AppRouter.language),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
