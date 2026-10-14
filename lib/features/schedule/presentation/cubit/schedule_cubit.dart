import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/subject_label.dart';
import '../../../tasks/domain/entities/task_entity.dart';
import '../../../tasks/domain/repositories/tasks_repository.dart';
import '../../domain/entities/schedule_entry.dart';
import 'schedule_state.dart';

/// الجدول اليومي **مُشتق من المهام** (مصدر الحقيقة الوحيد):
/// مهام اليوم + المتأخرة (pending) + ما أُنجز اليوم.
/// Why: كوليكسشن schedule المنفصل لم يكن يكتبه أحد → فراغ دائم.
class ScheduleCubit extends Cubit<ScheduleState> {
  final TasksRepository _tasksRepository;
  StreamSubscription<List<TaskEntity>>? _subscription;

  ScheduleCubit({required TasksRepository tasksRepository})
    : _tasksRepository = tasksRepository,
      super(
        ScheduleState(
          dateLabel: DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
        ),
      ) {
    _subscription = _tasksRepository.watchTasks().listen(_onTasksChanged);
  }

  void _onTasksChanged(List<TaskEntity> tasks) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final relevant = tasks.where((t) => _isRelevant(t, today)).toList()
      ..sort((a, b) => (a.dueDate ?? now).compareTo(b.dueDate ?? now));
    final views = relevant.map((t) => _toView(t)).toList();
    final done = relevant.where((t) => t.status == TaskStatus.completed).length;
    final percent = relevant.isEmpty ? 0.0 : done / relevant.length;
    emit(
      state.copyWith(
        entries: views,
        progressDisplay: '${(percent * 100).round()}%',
        progressValue: percent.clamp(0, 1),
        isLoading: false,
      ),
    );
  }

  bool _isRelevant(TaskEntity t, DateTime today) {
    if (t.status == TaskStatus.draft) return false;
    final due = t.dueDate;
    if (due != null) {
      final dueDay = DateTime(due.year, due.month, due.day);
      if (dueDay == today) return true;
      if (dueDay.isBefore(today) && t.status != TaskStatus.completed) {
        return true; // متأخرة — تحتاج انتباه اليوم.
      }
    }
    final done = t.completedAt;
    if (done != null) {
      final doneDay = DateTime(done.year, done.month, done.day);
      if (doneDay == today) return true;
    }
    return false;
  }

  ScheduleEntryView _toView(TaskEntity t) {
    final due = t.dueDate;
    return ScheduleEntryView(
      id: t.id,
      title: t.title,
      type: ScheduleEntryType.deepFocus,
      typeLabel: t.subject.subjectLabel,
      timeLabel: due == null
          ? '--:--'
          : '${due.hour % 12 == 0 ? 12 : due.hour % 12}:'
                '${due.minute.toString().padLeft(2, '0')} '
                '${due.hour < 12 ? 'AM' : 'PM'}',
      description: t.notes,
      progress: t.status == TaskStatus.completed ? 1 : 0,
      isResource: false,
      task: t,
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
