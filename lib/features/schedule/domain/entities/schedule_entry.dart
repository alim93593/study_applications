import '../../../../core/localization/schedule_strings.dart';

/// أنواع عناصر الجدول — تُستخدم في نسخ العرض (أيقونة + تسمية).
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
