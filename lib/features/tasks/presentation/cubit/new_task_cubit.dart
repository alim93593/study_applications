import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/subjects_repository.dart';
import '../../domain/repositories/tasks_repository.dart';
import 'new_task_state.dart';
import 'new_task_submission_mixin.dart';
import 'subject_options_mixin.dart';

/// منطق نموذج "مهمة جديدة/تعديل": التحقق وخيارات المواد والكتابة على
/// Firestore. الإرسال في TaskSubmissionMixin والمواد في SubjectOptionsMixin.
class NewTaskCubit extends Cubit<NewTaskState>
    with SubjectOptionsMixin, TaskSubmissionMixin {
  final TasksRepository _repository;
  final SubjectsRepository _subjectsRepository;
  TaskEntity? _editing;

  NewTaskCubit({
    required TasksRepository repository,
    required SubjectsRepository subjectsRepository,
  }) : _repository = repository,
       _subjectsRepository = subjectsRepository,
       super(const NewTaskState()) {
    subscribeSubjects();
  }

  @override
  TasksRepository get tasksRepository => _repository;

  @override
  SubjectsRepository get subjectsRepository => _subjectsRepository;

  @override
  TaskEntity? get editingTask => _editing;

  /// تعبئة النموذج ببيانات مهمة موجودة (وضع التعديل) — null = وضع الإنشاء.
  void startEditing(TaskEntity? task) {
    if (task == null) return;
    _editing = task;
    final d = task.dueDate;
    emit(
      state.copyWith(
        editingId: task.id,
        title: task.title,
        subject: task.subject,
        dueDate: d,
        dueDateDisplay: d == null ? '' : _formatDue(d),
        focusLevel: task.focusLevel,
        notes: task.notes,
      ),
    );
  }

  static String _formatDue(DateTime d) =>
      DateFormat('d MMM, h:mm a').format(d);

  void onTitleChanged(String value) => emit(state.copyWith(title: value));
  void onNotesChanged(String value) => emit(state.copyWith(notes: value));
  void onSubjectSelected(String value) => emit(state.copyWith(subject: value));

  void onFocusChanged(FocusLevel value) =>
      emit(state.copyWith(focusLevel: value));

  void onStartAddSubject() => emit(state.copyWith(addingSubject: true));

  void onDatePickerRequested() => emit(state.copyWith(requestDatePicker: true));

  void onDatePicked(DateTime? date) {
    emit(
      state.copyWith(
        requestDatePicker: false,
        dueDate: date,
        dueDateDisplay: date == null ? '' : _formatDue(date),
      ),
    );
  }

  void clearFailure() => emit(state.copyWith(failureMessage: ''));

  @override
  Future<void> close() {
    unsubscribeSubjects();
    return super.close();
  }
}
