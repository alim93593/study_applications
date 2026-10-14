import 'package:easy_localization/easy_localization.dart';

/// ترجمة اسم المادة بأمان: المواد الافتراضية مفاتيح تترجم، وأي اسم
/// يضيفه المستخدم يُعرض كما هو **بدون تحذيرات** easy_localization.
/// Why: trExists() لا يسجّل تحذيرًا بعكس tr() للمفاتيح المجهولة.
extension SubjectLabelX on String {
  String get subjectLabel => this.trExists() ? this.tr() : this;
}
