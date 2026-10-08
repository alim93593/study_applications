import 'package:equatable/equatable.dart';

import '../../domain/entities/task_entity.dart';

/// نسخة العرض الجاهزة — كل النصوص المحسوبة (meta) تُبنى في الـ Cubit لا في الواجهة.
class TaskView extends Equatable {
  final String id;
  final String title;
  final String subject;
  final String meta;
  final bool isOverdue;
  final bool isDraft;
  final TaskStatus status;

  const TaskView({
    required this.id,
    required this.title,
    required this.subject,
    required this.meta,
    this.isOverdue = false,
    this.isDraft = false,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    subject,
    meta,
    isOverdue,
    isDraft,
    status,
  ];
}
