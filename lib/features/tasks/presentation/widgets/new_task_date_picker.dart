import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/new_task_cubit.dart';

/// فتح منتقي التاريخ — يُستدعى من BlocListener (الأثر الجانبي في الـ Listener
/// حسب دستور الـSide Effects)، ومستخرج من الصفحة لاحترام قاعدة 100 سطر.
Future<void> pickTaskDate(BuildContext context) async {
  final cubit = context.read<NewTaskCubit>();
  final now = DateTime.now();
  final picked = await showDatePicker(
    context: context,
    initialDate: cubit.state.dueDate ?? now,
    firstDate: DateTime(now.year - 1),
    lastDate: DateTime(now.year + 3),
  );
  cubit.onDatePicked(picked);
}
