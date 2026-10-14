import 'dart:ui';

import 'package:flutter/material.dart';

import '../di/service_locator.dart';
import '../localization/app_strings.dart';
import '../../features/shell/presentation/cubit/shell_cubit.dart';
import 'app_nav_item.dart';

/// بوتون ناف بزجاج مصقول (Frosted Glass) — تمويه قوي + طبقة تلوين موحّدة
/// بشدة تمويه بسيطة + فاصل شعري علوي + ظل صاعد ناعم، بأسلوب iOS/Material.
/// Why: النسخة السابقة بتدرّج قوي (شفاف→سادة) بدت كتدرّج لوني مش زجاج.
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return DecoratedBox(
      // ظل صاعد يفصل الزجاج عن المحتوى — عمق واقعي.
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.45 : 0.08),
            blurRadius: 24,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: DecoratedBox(
            decoration: BoxDecoration(
              // طبقة زجاج شبه موحّدة: شفافية تسمح بظهور المحتوى المموّه خلفها.
              // Why: الأبيض عالي الشفافية كان يختفي فوق الخلفية الفاتحة (أبيض
              // على أبيض) → زجاج_LIGHT بتظليل رمادي-أزرق خفيف يبان كالدارك.
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? const [Color(0xCC16181C), Color(0xB8101216)]
                    : const [Color(0xE6F3F6F9), Color(0xCCEDF1F5)],
              ),
              border: Border(
                top: BorderSide(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.15)
                      : Colors.black.withValues(alpha: 0.12),
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  for (var i = 0; i < _items.length; i++)
                    Expanded(
                    child: AppNavItem(
                      icon: _items[i].$1,
                      labelKey: _items[i].$2,
                      isActive: currentIndex == i,
                      // تبديل التبويب داخل الشل نفسه — لا إعادة بناء الصفحة.
                      onTap: currentIndex == i
                          ? null
                          : () => sl<ShellCubit>().select(i),
                    ),
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
