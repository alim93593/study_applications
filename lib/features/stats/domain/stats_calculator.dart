import 'entities/study_session.dart';

/// حسابات شاشة الإحصائيات — منطق أعمال صافٍ (لا واجهات ولا Cubits هنا).
class StatsCalculator {
  const StatsCalculator._();

  static double focusHours(List<StudySession> sessions) {
    final minutes = sessions.fold<int>(0, (sum, s) => sum + s.minutes);
    return minutes / 60;
  }

  /// ساعات آخر 7 أيام (الأحدث يمينًا) لمخطط الأسبوع.
  static List<double> weeklyBars(List<StudySession> sessions, DateTime now) {
    final bars = List<double>.filled(7, 0);
    for (final s in sessions) {
      final diff = now
          .difference(DateTime(s.date.year, s.date.month, s.date.day))
          .inDays;
      if (diff >= 0 && diff < 7) {
        bars[6 - diff] += s.minutes / 60;
      }
    }
    return bars;
  }

  static int avgSessionMinutes(List<StudySession> sessions) {
    if (sessions.isEmpty) return 0;
    final minutes = sessions.fold<int>(0, (sum, s) => sum + s.minutes);
    return minutes ~/ sessions.length;
  }

  /// نسبة تغيّر متوسط الجلسة: آخر 7 أيام مقابل الـ7 قبلها (بالدقائق).
  static int consistencyDelta(List<StudySession> sessions, DateTime now) {
    int recent = 0, previous = 0, recentCount = 0, previousCount = 0;
    for (final s in sessions) {
      final diff = now
          .difference(DateTime(s.date.year, s.date.month, s.date.day))
          .inDays;
      if (diff >= 0 && diff < 7) {
        recent += s.minutes;
        recentCount++;
      } else if (diff >= 7 && diff < 14) {
        previous += s.minutes;
        previousCount++;
      }
    }
    if (recentCount == 0 || previousCount == 0) return 0;
    final recentAvg = recent / recentCount;
    final previousAvg = previous / previousCount;
    if (previousAvg == 0) return 100;
    return (((recentAvg - previousAvg) / previousAvg) * 100).round();
  }

  static List<({String subject, double hours})> distribution(
    List<StudySession> sessions,
  ) {
    final map = <String, double>{};
    for (final s in sessions) {
      map[s.subject] = (map[s.subject] ?? 0) + s.minutes / 60;
    }
    final entries =
        map.entries.map((e) => (subject: e.key, hours: e.value)).toList()
          ..sort((a, b) => b.hours.compareTo(a.hours));
    return entries.take(4).toList();
  }

  /// إنجاز القراءة: ≥15 ساعة تركيز مسجّلة.
  static bool readingMilestone(List<StudySession> sessions) =>
      focusHours(sessions) >= 15;

  /// إنجاز السبرنت: ≥10 مهام في نفس اليوم.
  static bool sprintMilestone(List<DateTime> completedDates) {
    final perDay = <String, int>{};
    for (final d in completedDates) {
      final key = '${d.year}-${d.month}-${d.day}';
      perDay[key] = (perDay[key] ?? 0) + 1;
    }
    return perDay.values.any((count) => count >= 10);
  }
}
