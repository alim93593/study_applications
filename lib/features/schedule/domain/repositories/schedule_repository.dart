import '../entities/schedule_entry.dart';

/// واجهة مستودع الجدول اليومي.
abstract class ScheduleRepository {
  Stream<List<ScheduleEntry>> watchToday();
}
