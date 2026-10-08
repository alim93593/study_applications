import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/localization/schedule_strings.dart';

enum ScheduleEntryType { deepFocus, lecture, lab, peerReview, resource }

extension ScheduleEntryTypeLabel on ScheduleEntryType {
  /// مفتاح ترجمة نوع العنصر — النصوص عبر الترجمة فقط.
  String get labelKey {
    switch (this) {
      case ScheduleEntryType.deepFocus:
        return ScheduleStrings.entryDeepFocus;
      case ScheduleEntryType.lecture:
        return ScheduleStrings.entryLecture;
      case ScheduleEntryType.lab:
        return ScheduleStrings.entryLab;
      case ScheduleEntryType.peerReview:
        return ScheduleStrings.entryPeerReview;
      case ScheduleEntryType.resource:
        return ScheduleStrings.entryResource;
    }
  }
}

/// عنصر زمني في جدول اليوم (users/{uid}/schedule) — شكله من تصميم Daily Rhythm.
class ScheduleEntry extends Equatable {
  final String id;
  final String title;
  final ScheduleEntryType type;
  final DateTime startTime;
  final String description;
  final String location;
  final double progress;
  final List<String> participants;

  const ScheduleEntry({
    required this.id,
    required this.title,
    required this.type,
    required this.startTime,
    this.description = '',
    this.location = '',
    this.progress = 0,
    this.participants = const [],
  });

  factory ScheduleEntry.fromMap(
    Map<String, dynamic> map, {
    required String id,
  }) {
    return ScheduleEntry(
      id: id,
      title: map['title'] as String? ?? '',
      type: ScheduleEntryType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => ScheduleEntryType.deepFocus,
      ),
      startTime: (map['startTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      description: map['description'] as String? ?? '',
      location: map['location'] as String? ?? '',
      progress: (map['progress'] as num?)?.toDouble() ?? 0,
      participants:
          (map['participants'] as List<dynamic>?)?.cast<String>() ?? const [],
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    type,
    startTime,
    description,
    location,
    progress,
    participants,
  ];
}
