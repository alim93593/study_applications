# Plan 005 — Schedule + Stats live data

## الجدول (من المهام)
1. `schedule_entry.dart` → enum فقط (يحذف كيان ScheduleEntry الميت).
2. `schedule_cubit.dart` → يستمع لـ TasksRepository، يصفّي غير المسودة
   إلى: dueDate اليوم | متأخرة pending | أُنجز اليوم؛ يبني ScheduleEntryView
   (typeLabel = المادة، timeLabel من dueDate، progress من الحالة).
3. حذف: `schedule_remote_data_source.dart`، `schedule_repository_impl.dart`،
   `schedule_repository.dart` + تحديث DI (`ScheduleCubit(tasksRepository)`).

## جلسات التركيز (يكتب في sessions)
4. `stats_remote_data_source.dart` + `addSession` (وثيقة {subject, minutes, date}).
5. `stats_repository` + `addSession` → `SessionsRepositoryImpl` (نطاق
   connectivity + Either). *أو* إضافة للـ StatsRepository القائمة — نمط
   أبسط: نوّسع StatsRepository بـ addSession.
6. DI: StatsRepositoryImpl يأخذ connectivity بالفعل ✓.
7. `focus_session_cubit.dart`: subject (من SubjectsRepository)،
   running/elapsedSeconds، start() Timer.periodic، stop() → addSession.
8. `focus_session_card.dart` على شاشة Home (قبل الكويك أكشن).
9. مفاتيح: focus_session_title/start/stop + ar/en.

## التحقق
10. analyze صفر + ≤100 سطر + flutter test + parity.
