import 'package:equatable/equatable.dart';

import '../../domain/entities/schedule_entry.dart';

/// نسخة عرض جاهزة — كل النصوص المحسوبة تُبنى في الـ Cubit.
class ScheduleEntryView extends Equatable {
  final String id;
  final String title;
  final ScheduleEntryType type;
  final String typeLabel;
  final String timeLabel;
  final String description;
  final String location;
  final double progress;
  final List<String> participants;
  final bool isResource;

  const ScheduleEntryView({
    required this.id,
    required this.title,
    required this.type,
    required this.typeLabel,
    required this.timeLabel,
    this.description = '',
    this.location = '',
    this.progress = 0,
    this.participants = const [],
    this.isResource = false,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    type,
    typeLabel,
    timeLabel,
    description,
    location,
    progress,
    participants,
    isResource,
  ];
}

class ScheduleState extends Equatable {
  final List<ScheduleEntryView> entries;
  final String dateLabel;
  final String progressDisplay;
  final double progressValue;
  final bool isLoading;

  const ScheduleState({
    this.entries = const [],
    this.dateLabel = '',
    this.progressDisplay = '0%',
    this.progressValue = 0,
    this.isLoading = true,
  });

  ScheduleState copyWith({
    List<ScheduleEntryView>? entries,
    String? dateLabel,
    String? progressDisplay,
    double? progressValue,
    bool? isLoading,
  }) {
    return ScheduleState(
      entries: entries ?? this.entries,
      dateLabel: dateLabel ?? this.dateLabel,
      progressDisplay: progressDisplay ?? this.progressDisplay,
      progressValue: progressValue ?? this.progressValue,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    entries,
    dateLabel,
    progressDisplay,
    progressValue,
    isLoading,
  ];
}
