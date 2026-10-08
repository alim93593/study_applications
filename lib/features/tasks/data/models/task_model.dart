import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/task_entity.dart';

/// نموذج Firestore لالمهمة — الحقول مبنية على نموذج "New Task" في الفيجما.
class TaskModel extends TaskEntity {
  const TaskModel({
    required super.id,
    required super.title,
    required super.subject,
    super.dueDate,
    super.focusLevel,
    super.notes,
    super.status,
    required super.createdAt,
    super.completedAt,
  });

  /// تحويل نتيجة استعلام Firestore إلى قائمة مهام مرتبة تنازليًا.
  /// Why: مستخرج من الـ DataSource لاحترام قاعدة 100 سطر.
  static List<TaskEntity> fromSnapshot(QuerySnapshot snapshot) {
    final tasks =
        snapshot.docs
            .map(
              (doc) => TaskModel.fromMap(
                doc.data() as Map<String, dynamic>,
                id: doc.id,
              ),
            )
            .toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return tasks;
  }

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      title: entity.title,
      subject: entity.subject,
      dueDate: entity.dueDate,
      focusLevel: entity.focusLevel,
      notes: entity.notes,
      status: entity.status,
      createdAt: entity.createdAt,
      completedAt: entity.completedAt,
    );
  }

  factory TaskModel.fromMap(Map<String, dynamic> map, {required String id}) {
    return TaskModel(
      id: id,
      title: map['title'] as String? ?? '',
      subject: map['subject'] as String? ?? '',
      dueDate: (map['dueDate'] as Timestamp?)?.toDate(),
      focusLevel: FocusLevel.values.firstWhere(
        (e) => e.name == map['focusLevel'],
        orElse: () => FocusLevel.medium,
      ),
      notes: map['notes'] as String? ?? '',
      status: TaskStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => TaskStatus.pending,
      ),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      completedAt: (map['completedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subject': subject,
      'dueDate': dueDate == null ? null : Timestamp.fromDate(dueDate!),
      'focusLevel': focusLevel.name,
      'notes': notes,
      'status': status.name,
      'createdAt': Timestamp.fromDate(createdAt),
      'completedAt': completedAt == null
          ? null
          : Timestamp.fromDate(completedAt!),
    };
  }
}
