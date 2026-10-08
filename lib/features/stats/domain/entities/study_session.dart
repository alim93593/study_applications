import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// جلسة تركيز مسجّلة (users/{uid}/sessions) — مصدر شاشة الإحصائيات.
class StudySession extends Equatable {
  final String id;
  final String subject;
  final int minutes;
  final DateTime date;

  const StudySession({
    required this.id,
    required this.subject,
    required this.minutes,
    required this.date,
  });

  factory StudySession.fromMap(Map<String, dynamic> map, {required String id}) {
    return StudySession(
      id: id,
      subject: map['subject'] as String? ?? '',
      minutes: (map['minutes'] as num?)?.toInt() ?? 0,
      date: (map['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [id, subject, minutes, date];
}
