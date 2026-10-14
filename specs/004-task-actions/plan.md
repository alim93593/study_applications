# Plan 004 — Task Delete & Edit

## الخطوات
1. مفاتيح جديدة: `task_delete`, `task_delete_title`,
   `task_delete_confirm`, `task_deleted` (TasksStrings) +
   `task_edit_title` (NewTaskStrings) في ar/en.
2. `TaskView` + حقل `entity` (من الـ Mapper) للتنقل بالتعديل.
3. `TasksState` + `successMessage` + `clearSuccess`؛
   `TasksCubit.deleteTask` تنجح → رسالة نجاح.
4. `TasksPage` listener يعرض الخطأ (أحمر) والنجاح (عادي).
5. `task_card_dismissible.dart` (جديد): Dismissible + حوار التأكيد.
6. `TaskCard` + `onEdit` (InkWell على الجسم)؛ `TasksList` يوصلها.
7. `NewTaskState` + `editingId`؛ `startEditing(TaskEntity)`؛
   استخراج الإرسال لـ `new_task_submission_mixin.dart` (aware بالتعديل)
   للبقاء ≤ 100 سطر.
8. `NewTaskPage(task)` من الراوتر + عنوان متغير؛ `NewTaskActions`
   وضع تعديل (إخفاء مسودة + save_changes).
9. الاختبارات: delete success/failure + startEditing/update.
