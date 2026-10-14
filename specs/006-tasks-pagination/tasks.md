# Tasks: 006 — Tasks Pagination

## DataSource Layer
- [ ] إضافة `watchTasksPage({int limit, DocumentSnapshot? startAfter})` في `tasks_remote_data_source.dart`
- [ ] إضافة `getTasksAfter({int limit, DocumentSnapshot? startAfter})` في `tasks_remote_data_source.dart`
- [ ] تحديث `FirebaseFirestoreService` لدعم `startAfterDocument` في `getCollectionStream`

## Repository Layer
- [ ] إضافة `watchTasksPage` و `getTasksAfter` في `tasks_repository.dart` (Interface)
- [ ] تنفيذ الدالتين في `tasks_repository_impl.dart` مع try-catch

## Cubit Layer
- [ ] تحديث `TasksState` لتشمل: `tasks`, `hasMore`, `isLoadingMore`, `isLoading`
- [ ] تحديث `TasksCubit` لاستخدام `watchTasksPage` بدلاً من `watchTasks`
- [ ] إضافة `loadMore()` method
- [ ] تحديث `copyWith` للحقول الجديدة

## UI Layer
- [ ] إضافة `ScrollController` في `tasks_page.dart`
- [ ] استدعاء `loadMore()` عند الوصول للأسفل (threshold: 200px)
- [ ] إضافة مؤشر تحميل `CircularProgressIndicator` في آخر القائمة
- [ ] إخفاء المؤشر عندما `hasMore = false`

## Tests
- [ ] إنشاء `tasks_pagination_test.dart`
- [ ] اختبار أول دفعة (20 عنصر)
- [ ] اختبار loadMore
- [ ] اختبار نهاية القائمة
- [ ] اختبار خطأ الشبكة

## Verification
- [ ] `flutter analyze lib test` — صفر مشاكل
- [ ] `flutter test` — كل الاختبارات تنجح
- [ ] التحقق من قاعدة 100 سطر لكل ملف
