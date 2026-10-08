# Plan 002 — Subjects Persist

## البنية (نفس نمط Tasks حرفيًا)
```
presentation/cubit/subject_options_mixin.dart  (اشتراك الستريم + onAddSubject)
domain/repositories/subjects_repository.dart   (واجهة: watch + add)
data/datasources/subjects_remote_data_source.dart (صفر try-catch)
data/repositories/subjects_repository_impl.dart   (try-catch + فحص نت + زرع)
```

## الخطوات
1. `SubjectsRemoteDataSource(+Impl)`: `watchSubjects()` أسماء مرتبة من
   `userSubjects(uid)` + `addSubject(name)` بوثيقة `{name, createdAt}`.
   uid فارغ → ستريم فاضي / رمي خطأ يُلتقط في المستودع.
2. `SubjectsRepository` واجهة + `SubjectsRepositoryImpl`:
   فحص الاتصال قبل أي طلب، زرع الافتراضيات مرة واحدة عبر
   `PreferencesService.subjectsSeeded`، تحويل الأخطاء إلى
   `Either<Failure, void>` (`subject_add_failed`).
3. `PreferencesService`: علَم `subjectsSeeded` (getter + setter).
4. `subject_options_mixin.dart`: يستبدل `SubjectOptionsSource`
   (يُحذف ملفه): اشتراك، اختيار افتراضي، منع التكرار، تفاؤلية + رسالة خطأ.
5. `NewTaskCubit`: `with SubjectOptionsMixin` + حقن `SubjectsRepository`
   (يبقى ≤ 100 سطر). الواجهة لا تتغير (`onSubmitted: cubit.onAddSubject`).
6. DI في `task_feature_module.dart` + مفتاح `subject_add_failed` في
   `NewTaskStrings` و`ar/en.json`.

## ملاحظة معمارية
لا UseCase منفصل — الـ Cubit ينادي المستودع مباشرة مثل `TasksCubit`
(النمط المعتمد في المشروع للـ CRUD البسيط).
