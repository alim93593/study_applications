import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/subjects_repository.dart';
import 'new_task_state.dart';

/// Firestore-backed subject options — extracted from NewTaskCubit to respect
/// the 100-line rule. Owns the options subscription, dedup, optimistic
/// selection, and persist-failure reporting.
mixin SubjectOptionsMixin on Cubit<NewTaskState> {
  SubjectsRepository get subjectsRepository;

  StreamSubscription<List<String>>? _optionsSub;

  void subscribeSubjects() {
    _optionsSub = subjectsRepository.watchSubjects().listen(_onSubjects);
  }

  void _onSubjects(List<String> options) {
    emit(
      state.copyWith(
        subjectOptions: options,
        subject: state.subject.isEmpty && options.isNotEmpty
            ? options.first
            : state.subject,
      ),
    );
  }

  void unsubscribeSubjects() {
    _optionsSub?.cancel();
  }

  Future<void> onAddSubject(String value) async {
    final name = value.trim();
    if (name.isEmpty) {
      return;
    }
    final match = state.subjectOptions.where(
      (o) => o.trim().toLowerCase() == name.toLowerCase(),
    );
    if (match.isNotEmpty) {
      emit(state.copyWith(subject: match.first, addingSubject: false));
      return;
    }
    emit(state.copyWith(subject: name, addingSubject: false));
    final result = await subjectsRepository.addSubject(name);
    result.fold(
      (failure) => emit(state.copyWith(failureMessage: failure.message.tr())),
      (_) {},
    );
  }
}
