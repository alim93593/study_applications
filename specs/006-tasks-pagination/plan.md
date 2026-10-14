# Plan: 006 — Tasks Pagination

## البنية المعمارية
- **DataSource**: إضافة `watchTasksPage()` + `getTasksAfter()` 
- **Repository**: إضافة `watchTasksPage()` و `getTasksAfter()` (التقاط الأخطاء هنا فقط)
- **Cubit**: إضافة pagination state + `loadMore()` 
- **UI**: ScrollController + مؤشر تحميل في أسفل القائمة

## الملفات المتأثرة

### 1. DataSource (`tasks_remote_data_source.dart`)
```dart
// جديد
Stream<QuerySnapshot> watchTasksPage({int limit, DocumentSnapshot? startAfter});
Future<QuerySnapshot> getTasksAfter({int limit, DocumentSnapshot? startAfter});
```

### 2. Repository Interface (`tasks_repository.dart`)
```dart
// جديد
Stream<List<TaskEntity>> watchTasksPage({int limit, TaskEntity? startAfter});
Future<List<TaskEntity>> getTasksAfter({int limit, TaskEntity? startAfter});
```

### 3. Repository Impl (`tasks_repository_impl.dart`)
- تنفيذ الدالتين الجديدتين
- try-catch هنا فقط (قواعد AGENTS)

### 4. Cubit (`tasks_cubit.dart`)
```dart
// State جديد
final List<TaskEntity> tasks;
final bool hasMore;
final bool isLoadingMore;
final bool isLoading;

// Methods
void loadMore(); // يحمّل الدفعة التالية
```

### 5. UI (`tasks_page.dart` / `tasks_list.dart`)
- `ScrollController` يراقب الوصول للأسفل
- `loadMore()` عند `_position >= _maxScroll - 200`
- مؤشر تحميل `CircularProgressIndicator` في آخر القائمة

## القرارات التقنية
1. **أول دفعة real-time** (`snapshots()`) — عشان التحديثات الحية للصفحة الأولى
2. **الصفحات التالية one-time** (`get()`) — أبسط وأسرع
3. **startAfter = آخر عنصر في الصفحة الحالية** — cursor-based
4. **pageSize = 20** — رقم متوازن بين السرعة والتجربة

## اختبارات
- `tasks_pagination_test.dart`:
  - أول دفعة = 20 عنصر
  - loadMore يضيف 20 جديد
  - نهاية القائمة → hasMore = false
  - خطأ في الشبكة → حالة error
