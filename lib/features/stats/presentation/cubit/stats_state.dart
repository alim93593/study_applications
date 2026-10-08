import 'package:equatable/equatable.dart';

/// بطاقة إنجاز (مترجمة في الـ Cubit).
class MilestoneView extends Equatable {
  final String title;
  final String description;

  const MilestoneView({required this.title, required this.description});

  @override
  List<Object?> get props => [title, description];
}

class StatsState extends Equatable {
  final String focusHoursDisplay;
  final List<double> weeklyBars;
  final String completedDisplay;
  final double weeklyGoalValue;
  final String weeklyGoalDisplay;
  final String avgSessionDisplay;
  final String consistencyDisplay;
  final List<({String subject, String hoursDisplay})> distribution;
  final List<MilestoneView> milestones;
  final bool isLoading;

  const StatsState({
    this.focusHoursDisplay = '0',
    this.weeklyBars = const [],
    this.completedDisplay = '0/0',
    this.weeklyGoalValue = 0,
    this.weeklyGoalDisplay = '',
    this.avgSessionDisplay = '0',
    this.consistencyDisplay = '',
    this.distribution = const [],
    this.milestones = const [],
    this.isLoading = true,
  });

  StatsState copyWith({
    String? focusHoursDisplay,
    List<double>? weeklyBars,
    String? completedDisplay,
    double? weeklyGoalValue,
    String? weeklyGoalDisplay,
    String? avgSessionDisplay,
    String? consistencyDisplay,
    List<({String subject, String hoursDisplay})>? distribution,
    List<MilestoneView>? milestones,
    bool? isLoading,
  }) {
    return StatsState(
      focusHoursDisplay: focusHoursDisplay ?? this.focusHoursDisplay,
      weeklyBars: weeklyBars ?? this.weeklyBars,
      completedDisplay: completedDisplay ?? this.completedDisplay,
      weeklyGoalValue: weeklyGoalValue ?? this.weeklyGoalValue,
      weeklyGoalDisplay: weeklyGoalDisplay ?? this.weeklyGoalDisplay,
      avgSessionDisplay: avgSessionDisplay ?? this.avgSessionDisplay,
      consistencyDisplay: consistencyDisplay ?? this.consistencyDisplay,
      distribution: distribution ?? this.distribution,
      milestones: milestones ?? this.milestones,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    focusHoursDisplay,
    weeklyBars,
    completedDisplay,
    weeklyGoalValue,
    weeklyGoalDisplay,
    avgSessionDisplay,
    consistencyDisplay,
    distribution,
    milestones,
    isLoading,
  ];
}
