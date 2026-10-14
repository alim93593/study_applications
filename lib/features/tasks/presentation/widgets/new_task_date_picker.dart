import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/new_task_cubit.dart';

/// فتح منتقي التاريخ ثم الوقت — يُستدعى من BlocListener (الأثر الجانبي في
/// الـ Listener حسب دستور الـ Side Effects).
/// Why: منتقي التاريخ وحده ينتج dueDate منتصف الليل → "12:00 AM" لكل المهام
/// في الجدول؛ دمج التاريخ + الوقت يعطي أوقاتًا حقيقية منطقية.
Future<void> pickTaskDate(BuildContext context) async {
  final cubit = context.read<NewTaskCubit>();
  final now = DateTime.now();
  final pickedDate = await showDatePicker(
    context: context,
    initialDate: cubit.state.dueDate ?? now,
    firstDate: DateTime(now.year - 1),
    lastDate: DateTime(now.year + 3),
  );
  if (pickedDate == null) {
    cubit.onDatePicked(null);
    return;
  }
  // فحص mounted بعد الـ await الأول قبل استخدام Context تاني (Lint).
  if (!context.mounted) return;
  final fallbackTime = TimeOfDay.fromDateTime(cubit.state.dueDate ?? now);
  final pickedTime = await showTimePicker(
    context: context,
    initialTime: fallbackTime,
  );
  final time = pickedTime ?? fallbackTime;
  cubit.onDatePicked(
    DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      time.hour,
      time.minute,
    ),
  );
}
