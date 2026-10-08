import 'package:easy_localization/easy_localization.dart';

import '../../../core/localization/tasks_strings.dart';
import '../domain/entities/task_entity.dart';
import 'cubit/tasks_state.dart';

/// ترجمة كيان المهمة إلى نسخة عرض (نصوص due/ago مبنية هنا لا في الواجهات).
class TasksDisplayMapper {
  const TasksDisplayMapper._();

  static TaskView toView(TaskEntity task) {
    final overdue =
        task.dueDate != null && task.dueDate!.isBefore(DateTime.now());
    return TaskView(
      id: task.id,
      title: task.title,
      subject: task.subject.tr(),
      meta: metaFor(task, overdue: overdue),
      isOverdue: overdue && task.status != TaskStatus.completed,
      isDraft: task.status == TaskStatus.draft,
      status: task.status,
    );
  }

  static String metaFor(TaskEntity task, {required bool overdue}) {
    if (task.status == TaskStatus.draft) {
      return TasksStrings.taskDraft.tr();
    }
    if (task.status == TaskStatus.completed) {
      return '${task.subject.tr()} · ${TasksStrings.taskCompletedWith.tr(args: [ago(task.completedAt)])}';
    }
    if (task.dueDate == null) return task.subject.tr();
    if (overdue) {
      return '${task.subject.tr()} · ${TasksStrings.taskOverdue.tr()}';
    }
    final diff = task.dueDate!.difference(DateTime.now());
    if (diff.inHours < 24) {
      return '${task.subject.tr()} · ${TasksStrings.taskDueInHours.tr(args: ['${diff.inHours}'])}';
    }
    final days = diff.inDays;
    if (days < 7) {
      return '${task.subject.tr()} · ${TasksStrings.taskDueInDays.tr(args: ['$days'])}';
    }
    final d = task.dueDate!;
    return '${task.subject.tr()} · ${TasksStrings.taskDueOn.tr(args: ['${d.day}/${d.month}'])}';
  }

  static String ago(DateTime? time) {
    if (time == null) return '';
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 60) {
      return TasksStrings.timeMinutes.tr(args: ['${diff.inMinutes}']);
    }
    if (diff.inHours < 24) {
      return TasksStrings.timeHours.tr(args: ['${diff.inHours}']);
    }
    return TasksStrings.timeToday.tr();
  }
}
