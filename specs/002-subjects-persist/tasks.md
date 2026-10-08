# Tasks 002 — Subjects Persist

- [ ] DS: `subjects_remote_data_source.dart` (watch + add، صفر try-catch).
- [ ] Domain: `subjects_repository.dart` (واجهة).
- [ ] Repo impl: فحص نت + زرع + `Either` (≤ 100 سطر).
- [ ] Prefs: `subjectsSeeded` getter/setter.
- [ ] Strings: `subject_add_failed` في `NewTaskStrings` + ar/en.
- [ ] Mixin: `subject_options_mixin.dart` (اشتراك + إضافة + منع تكرار).
- [ ] Cubit: تحويل لـ mixin + حقن المستودع (≤ 100 سطر).
- [ ] DI: تسجيل DS + Repo + تحديث `NewTaskCubit` factory.
- [ ] حذف `subject_options_source.dart` (ميت).
- [ ] تحقق: `flutter analyze` صفر + كل ملف `wc -l ≤ 100` + `flutter test`.
- [ ] تجربة يدوية: إضافة مادة → تظهر في Firestore Console + الشرائح
      بعد إعادة الفتح؛ أوفلاين → رسالة خطأ.
