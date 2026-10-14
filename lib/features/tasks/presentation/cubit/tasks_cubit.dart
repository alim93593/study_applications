import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/tasks_strings.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/tasks_repository.dart';
import '../tasks_display_mapper.dart';
import 'tasks_state.dart';

/// منطق المهام كله هنا — النصوص المحسوبة في TasksDisplayMapper.
/// Why: باجنبيشن cursor-based — أول صفحة real-time والباقي one-time.
class TasksCubit extends Cubit<TasksState> {
  static const int _pageSize = 20;

  final TasksRepository _repository;
  StreamSubscription<List<TaskEntity>>? _subscription;
  final List<TaskEntity> _allTasks = [];

  TasksCubit({required TasksRepository repository})
    : _repository = repository,
      super(const TasksState()) {
    _subscription = _repository
        .watchTasksPage(limit: _pageSize)
        .listen(_onFirstPageChanged);
  }

  void _onFirstPageChanged(List<TaskEntity> tasks) {
    _allTasks
      ..clear()
      ..addAll(tasks);
    _emitTasks(hasMore: tasks.length >= _pageSize);
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;
    emit(state.copyWith(isLoadingMore: true));
    final r = await _repository.getTasksNextPage(limit: _pageSize);
    r.fold(
      (f) => emit(
        state.copyWith(isLoadingMore: false, failureMessage: f.message.tr()),
      ),
      (t) {
        if (t.isEmpty) {
          emit(state.copyWith(isLoadingMore: false, hasMore: false));
        } else {
          _allTasks.addAll(t);
          _emitTasks(hasMore: t.length >= _pageSize, isLoadingMore: false);
        }
      },
    );
  }

  void _emitTasks({required bool hasMore, bool isLoadingMore = false}) {
    final pending = <TaskView>[];
    final completed = <TaskView>[];
    for (final t in _allTasks) {
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
        hasMore: hasMore,
        isLoadingMore: isLoadingMore,
      ),
    );
  }

  Future<void> toggleComplete(TaskView view) async {
    final r = await _repository.toggleComplete(
      view.id,
      completed: view.status != TaskStatus.completed,
    );
    r.fold(
      (f) => emit(state.copyWith(failureMessage: f.message.tr())),
      (_) {},
    );
  }

  Future<void> updateTask(TaskEntity task) async {
    final r = await _repository.updateTask(task);
    r.fold((f) => emit(state.copyWith(failureMessage: f.message.tr())), (_) {});
  }

  Future<void> deleteTask(String id) async {
    final r = await _repository.deleteTask(id);
    r.fold(
      (f) => emit(state.copyWith(failureMessage: f.message.tr())),
      (_) => emit(state.copyWith(successMessage: TasksStrings.taskDeleted.tr())),
    );
  }

  void selectTab(int i) => emit(state.copyWith(selectedTab: i));
  void clearFailure() => emit(state.copyWith(failureMessage: ''));
  void clearSuccess() => emit(state.copyWith(successMessage: ''));

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
