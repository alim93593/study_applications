import 'package:intl/intl.dart';

/// Why: date display strings must be produced outside the widget tree —
/// the Zero UI Logic rule forbids formatting dates inside any Widget.
abstract class AppDateFormatter {
  AppDateFormatter._();

  static String dob(DateTime date) => DateFormat('dd/MM/yyyy').format(date);
}
