import 'package:equatable/equatable.dart';

import '../../../../core/localization/new_task_strings.dart';

enum TaskStatus { pending, completed, draft }

enum FocusLevel { deep, high, medium, low }

extension FocusLevelLabel on FocusLevel {
  /// مفتاح ترجمة مستوى التركيز — النصوص تُعرض عبر الترجمة فقط.
  String get labelKey {
    switch (this) {
      case FocusLevel.deep:
        return NewTaskStrings.focusLevelDeep;
      case FocusLevel.high:
        return NewTaskStrings.focusLevelHigh;
      case FocusLevel.medium:
        return NewTaskStrings.focusLevelMedium;
      case FocusLevel.low:
        return NewTaskStrings.focusLevelLow;
    }
  }
}

/// وحدة العمل الأساسية (مهمة بحث/دراسة) — تُستخدم في المهام والجدول والإحصائيات.
class TaskEntity extends Equatable {
  final String id;
  final String title;
  final String subject;
  final DateTime? dueDate;
  final FocusLevel focusLevel;
  final String notes;
  final TaskStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.subject,
    this.dueDate,
    this.focusLevel = FocusLevel.medium,
    this.notes = '',
    this.status = TaskStatus.pending,
    required this.createdAt,
    this.completedAt,
  });

  TaskEntity copyWith({
    String? title,
    String? subject,
    DateTime? dueDate,
    FocusLevel? focusLevel,
    String? notes,
    TaskStatus? status,
    DateTime? completedAt,
  }) {
    return TaskEntity(
      id: id,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      dueDate: dueDate ?? this.dueDate,
      focusLevel: focusLevel ?? this.focusLevel,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    subject,
    dueDate,
    focusLevel,
    notes,
    status,
    createdAt,
    completedAt,
  ];
}
