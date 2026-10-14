import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/localization/new_task_strings.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/tasks_repository.dart';
import 'new_task_state.dart';

/// إرسال نموذج المهمة (إنشاء/مسودة/تعديل) — مستخرج من NewTaskCubit
/// لاحترام قاعدة 100 سطر. وضع التعديل يحافظ على id/createdAt.
mixin TaskSubmissionMixin on Cubit<NewTaskState> {
  TasksRepository get tasksRepository;

  TaskEntity? get editingTask;

  Future<void> submitAsTask() => _submit(TaskStatus.pending);

  Future<void> submitAsDraft() => _submit(TaskStatus.draft);

  Future<void> _submit(TaskStatus status) async {
    if (state.title.trim().isEmpty) {
      emit(state.copyWith(failureMessage: NewTaskStrings.errorTaskTitle.tr()));
      return;
    }
    emit(state.copyWith(submitting: true, failureMessage: ''));
    final editing = editingTask;
    final entity = TaskEntity(
      id: editing?.id ?? const Uuid().v4(),
      title: state.title.trim(),
      subject: state.subject,
      dueDate: status == TaskStatus.draft ? null : state.dueDate,
      focusLevel: state.focusLevel,
      notes: state.notes,
      status: _resolveStatus(editing, status),
      createdAt: editing?.createdAt ?? DateTime.now(),
      completedAt: editing?.completedAt,
    );
    final result = editing == null
        ? await tasksRepository.addTask(entity)
        : await tasksRepository.updateTask(entity);
    result.fold(
      (failure) => emit(
        state.copyWith(submitting: false, failureMessage: failure.message.tr()),
      ),
      (_) => emit(state.copyWith(submitting: false, submitted: true)),
    );
  }

  /// المهمة المكتملة تفضل مكتملة عند التعديل؛ المسودة تصير نشطة بحفظ أساسي.
  TaskStatus _resolveStatus(TaskEntity? editing, TaskStatus requested) {
    if (editing == null) return requested;
    if (requested == TaskStatus.draft) return TaskStatus.draft;
    return editing.status == TaskStatus.draft
        ? TaskStatus.pending
        : editing.status;
  }
}
