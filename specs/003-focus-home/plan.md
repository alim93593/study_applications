# Plan 003 — Focus/Home Redesign

## الخطوات
1. `core/localization/home_strings.dart` + مفاتيح `home_today_tasks`,
   `home_focus_today`, `home_completion` في ar/en.
2. `features/home/presentation/cubit/`:
   - `home_state.dart`: todayTasksDisplay / focusHoursDisplay /
     completionDisplay / isLoading(افتراضي true).
   - `home_cubit.dart`: اشتراك المهام + الجلسات، `_recompute()` بنمط
     StatsCubit (منطق الأعمال في Cubit، صفر في UI).
3. DI: `core/di/home_feature_module.dart` + نداء في `service_locator.dart`
   (مع ضغط التعليقات للبقاء ≤ 100 سطر).
4. `home_stats_row.dart`: `BlocSelector<HomeCubit, HomeState>` + بطاقات
   جديدة (Icons.today / Icons.timer / Icons.check_circle) — حذف points.
5. `home_quick_actions.dart`: أزرار جديدة بـ `onTap` حقيقي (navigation
   عبر ثوابت AppRouter/AppNavigator فقط) — حذف quiz/leaderboard.
6. `home_page.dart`: `BlocProvider(create: HomeCubit)` فوق الـ Scaffold.
7. Unit tests: `test/features/home/home_cubit_test.dart` بفِيكات
   `noSuchMethod` (نمط مشروع الحالي، بلا mock package).
