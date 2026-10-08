import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../localization/app_strings.dart';
import '../navigator/app_navigator.dart';
import '../router/app_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_colors_extension.dart';
import '../theme/app_text_styles.dart';

/// البوتون ناف الموحد (Focus / Tasks / Schedule / Library) كما في التصاميم.
class AppBottomNav extends StatelessWidget {
  final int currentIndex;

  const AppBottomNav({super.key, this.currentIndex = 0});

  static const List<(IconData, String)> _items = [
    (Icons.timer_outlined, AppStrings.navFocus),
    (Icons.checklist_rounded, AppStrings.navTasks),
    (Icons.calendar_month_outlined, AppStrings.navSchedule),
    (Icons.bar_chart_outlined, AppStrings.navStats),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.card,
        border: Border(top: BorderSide(color: context.colors.softBorder)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            for (var i = 0; i < _items.length; i++)
              Expanded(
                child: _NavItem(
                  icon: _items[i].$1,
                  labelKey: _items[i].$2,
                  isActive: currentIndex == i,
                  onTap: currentIndex == i
                      ? null
                      : () => AppNavigator.pushReplacement(
                          AppRouter.shell,
                          arguments: i,
                        ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String labelKey;
  final bool isActive;
  final VoidCallback? onTap;

  const _NavItem({
    required this.icon,
    required this.labelKey,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : context.colors.textHint;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 3,
            width: 36,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(height: 8),
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 4),
          Text(
            labelKey.tr(),
            style: AppTextStyles.captionGlass.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
