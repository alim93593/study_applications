import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final String todayTasksDisplay;
  final String focusHoursDisplay;
  final String completionDisplay;
  final bool isLoading;
  /// دقائق التركيز لآخر 7 أيام (الاثنين → الأحد) — للمخطط الأسبوعي.
  final List<int> weeklyFocusMinutes;
  /// نص أيام الأسبوع القصير مترجم (حسب لغة التطبيق وقت الحساب).
  final List<String> weeklyDayLabels;
  /// إجمالي دقائق آخر 7 أيام — للعنوان في المخطط.
  final int weeklyTotalMinutes;

  const HomeState({
    this.todayTasksDisplay = '0',
    this.focusHoursDisplay = '0.0',
    this.completionDisplay = '0%',
    this.isLoading = true,
    this.weeklyFocusMinutes = const [0, 0, 0, 0, 0, 0, 0],
    this.weeklyDayLabels = const ['', '', '', '', '', '', ''],
    this.weeklyTotalMinutes = 0,
  });

  @override
  List<Object?> get props => [
    todayTasksDisplay,
    focusHoursDisplay,
    completionDisplay,
    isLoading,
    weeklyFocusMinutes,
    weeklyDayLabels,
    weeklyTotalMinutes,
  ];
}
