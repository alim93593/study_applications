import 'package:equatable/equatable.dart';

import '../../domain/entities/task_entity.dart';

class NewTaskState extends Equatable {
  final String title;
  final String subject;
  final List<String> subjectOptions;
  final DateTime? dueDate;
  final String dueDateDisplay;
  final FocusLevel focusLevel;
  final String notes;
  final bool addingSubject;
  final bool requestDatePicker;
  final bool submitting;
  final bool submitted;
  final String failureMessage;

  const NewTaskState({
    this.title = '',
    this.subject = '',
    this.subjectOptions = const [],
    this.dueDate,
    this.dueDateDisplay = '',
    this.focusLevel = FocusLevel.deep,
    this.notes = '',
    this.addingSubject = false,
    this.requestDatePicker = false,
    this.submitting = false,
    this.submitted = false,
    this.failureMessage = '',
  });

  NewTaskState copyWith({
    String? title,
    String? subject,
    List<String>? subjectOptions,
    DateTime? dueDate,
    String? dueDateDisplay,
    FocusLevel? focusLevel,
    String? notes,
    bool? addingSubject,
    bool? requestDatePicker,
    bool? submitting,
    bool? submitted,
    String? failureMessage,
  }) {
    return NewTaskState(
      title: title ?? this.title,
      subject: subject ?? this.subject,
      subjectOptions: subjectOptions ?? this.subjectOptions,
      dueDate: dueDate ?? this.dueDate,
      dueDateDisplay: dueDateDisplay ?? this.dueDateDisplay,
      focusLevel: focusLevel ?? this.focusLevel,
      notes: notes ?? this.notes,
      addingSubject: addingSubject ?? this.addingSubject,
      requestDatePicker: requestDatePicker ?? this.requestDatePicker,
      submitting: submitting ?? this.submitting,
      submitted: submitted ?? this.submitted,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [
    title,
    subject,
    subjectOptions,
    dueDate,
    dueDateDisplay,
    focusLevel,
    notes,
    addingSubject,
    requestDatePicker,
    submitting,
    submitted,
    failureMessage,
  ];
}
