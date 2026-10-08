import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/localization/new_task_strings.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/subjects_repository.dart';
import '../../domain/repositories/tasks_repository.dart';
import 'new_task_state.dart';
import 'subject_options_mixin.dart';

/// منطق نموذج "مهمة جديدة": التحقق وخيارات المواد والكتابة على Firestore.
/// خيارات المواد (ستريم + حفظ) في SubjectOptionsMixin — مادة جديدة تُحفظ
/// في users/{uid}/subjects فور إضافتها (FR-S01).
class NewTaskCubit extends Cubit<NewTaskState> with SubjectOptionsMixin {
  final TasksRepository _repository;
  final SubjectsRepository _subjectsRepository;

  NewTaskCubit({
    required TasksRepository repository,
    required SubjectsRepository subjectsRepository,
  }) : _repository = repository,
       _subjectsRepository = subjectsRepository,
       super(const NewTaskState()) {
    subscribeSubjects();
  }

  @override
  SubjectsRepository get subjectsRepository => _subjectsRepository;

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
        dueDateDisplay: date == null
            ? ''
            : '${date.month}/${date.day}/${date.year}',
      ),
    );
  }

  void clearFailure() => emit(state.copyWith(failureMessage: ''));

  Future<void> submitAsTask() => _submit(TaskStatus.pending);

  Future<void> submitAsDraft() => _submit(TaskStatus.draft);

  Future<void> _submit(TaskStatus status) async {
    if (state.title.trim().isEmpty) {
      emit(state.copyWith(failureMessage: NewTaskStrings.errorTaskTitle.tr()));
      return;
    }
    emit(state.copyWith(submitting: true, failureMessage: ''));
    final result = await _repository.addTask(
      TaskEntity(
        id: const Uuid().v4(),
        title: state.title.trim(),
        subject: state.subject,
        dueDate: status == TaskStatus.draft ? null : state.dueDate,
        focusLevel: state.focusLevel,
        notes: state.notes,
        status: status,
        createdAt: DateTime.now(),
      ),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(submitting: false, failureMessage: failure.message.tr()),
      ),
      (_) => emit(state.copyWith(submitting: false, submitted: true)),
    );
  }

  @override
  Future<void> close() {
    unsubscribeSubjects();
    return super.close();
  }
}
