import 'package:equatable/equatable.dart';

import 'task_view.dart';

export 'task_view.dart';

/// حالة قائمة المهام — نموذج العرض TaskView في ملفه الخاص (task_view.dart).
class TasksState extends Equatable {
  final List<TaskView> pending;
  final List<TaskView> completed;
  final int activeCount;
  final int archivedCount;
  final String activeDisplay;
  final String archivedDisplay;
  final double insightProgress;
  final bool isLoading;
  final String failureMessage;
  final int selectedTab; // 0 = pending, 1 = completed

  const TasksState({
    this.pending = const [],
    this.completed = const [],
    this.activeCount = 0,
    this.archivedCount = 0,
    this.activeDisplay = '00',
    this.archivedDisplay = '00',
    this.insightProgress = 0,
    this.isLoading = true,
    this.failureMessage = '',
    this.selectedTab = 0,
  });

  TasksState copyWith({
    List<TaskView>? pending,
    List<TaskView>? completed,
    int? activeCount,
    int? archivedCount,
    String? activeDisplay,
    String? archivedDisplay,
    double? insightProgress,
    bool? isLoading,
    String? failureMessage,
    int? selectedTab,
  }) {
    return TasksState(
      pending: pending ?? this.pending,
      completed: completed ?? this.completed,
      activeCount: activeCount ?? this.activeCount,
      archivedCount: archivedCount ?? this.archivedCount,
      activeDisplay: activeDisplay ?? this.activeDisplay,
      archivedDisplay: archivedDisplay ?? this.archivedDisplay,
      insightProgress: insightProgress ?? this.insightProgress,
      isLoading: isLoading ?? this.isLoading,
      failureMessage: failureMessage ?? this.failureMessage,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }

  @override
  List<Object?> get props => [
    pending,
    completed,
    activeCount,
    archivedCount,
    activeDisplay,
    archivedDisplay,
    insightProgress,
    isLoading,
    failureMessage,
    selectedTab,
  ];
}
