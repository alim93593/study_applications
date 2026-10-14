import '../../../../core/localization/stats_strings.dart';

/// مفاتيح تسميات أيام الأسبوع القصيرة للمخطط الأسبوعي.
/// Why: DateFormat.E() بتجيب الإنجليزي مهما كانت لغة التطبيق؛ مفاتيح
/// مترجمة هي الحل الموثوق (Zero hardcoded + دعم RTL كامل).
abstract class StatsLabelKeys {
  const StatsLabelKeys._();

  static String weekdayKey(int weekday) => switch (weekday) {
    DateTime.monday => StatsStrings.dayShortMon,
    DateTime.tuesday => StatsStrings.dayShortTue,
    DateTime.wednesday => StatsStrings.dayShortWed,
    DateTime.thursday => StatsStrings.dayShortThu,
    DateTime.friday => StatsStrings.dayShortFri,
    DateTime.saturday => StatsStrings.dayShortSat,
    _ => StatsStrings.dayShortSun,
  };
}
