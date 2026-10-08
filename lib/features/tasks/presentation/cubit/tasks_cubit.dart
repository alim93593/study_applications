import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/tasks_repository.dart';
import '../tasks_display_mapper.dart';
import 'tasks_state.dart';

/// منطق المهام كله هنا — النصوص المحسوبة في TasksDisplayMapper.
class TasksCubit extends Cubit<TasksState> {
  final TasksRepository _repository;
  StreamSubscription<List<TaskEntity>>? _subscription;

  TasksCubit({required TasksRepository repository})
    : _repository = repository,
      super(const TasksState()) {
    _subscription = _repository.watchTasks().listen(_onTasksChanged);
  }

  void _onTasksChanged(List<TaskEntity> tasks) {
    final pending = <TaskView>[];
    final completed = <TaskView>[];
    for (final t in tasks) {
      final view = TasksDisplayMapper.toView(t);
      (t.status == TaskStatus.completed ? completed : pending).add(view);
    }
    final total = pending.length + completed.length;
    emit(
      state.copyWith(
        pending: pending,
        completed: completed,
        activeCount: pending.length,
        archivedCount: completed.length,
        activeDisplay: pending.length.toString().padLeft(2, '0'),
        archivedDisplay: completed.length.toString().padLeft(2, '0'),
        insightProgress: total == 0 ? 0 : pending.length / total,
        isLoading: false,
      ),
    );
  }

  Future<void> toggleComplete(TaskView view) async {
    final result = await _repository.toggleComplete(
      view.id,
      completed: view.status != TaskStatus.completed,
    );
    result.fold(
      (failure) => emit(state.copyWith(failureMessage: failure.message.tr())),
      (_) {},
    );
  }

  Future<void> updateTask(TaskEntity task) async {
    final result = await _repository.updateTask(task);
    result.fold(
      (failure) => emit(state.copyWith(failureMessage: failure.message.tr())),
      (_) {},
    );
  }

  Future<void> deleteTask(String id) async {
    final result = await _repository.deleteTask(id);
    result.fold(
      (failure) => emit(state.copyWith(failureMessage: failure.message.tr())),
      (_) {},
    );
  }

  void selectTab(int index) => emit(state.copyWith(selectedTab: index));

  void clearFailure() => emit(state.copyWith(failureMessage: ''));

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
