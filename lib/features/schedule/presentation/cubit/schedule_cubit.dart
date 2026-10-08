import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/schedule_entry.dart';
import '../../domain/repositories/schedule_repository.dart';
import 'schedule_state.dart';

/// كل حسابات العرض (الوقت، النوع، نسبة الإنجاز) هنا — صفر منطق في الواجهات.
class ScheduleCubit extends Cubit<ScheduleState> {
  final ScheduleRepository _repository;
  StreamSubscription<List<ScheduleEntry>>? _subscription;

  ScheduleCubit({required ScheduleRepository repository})
    : _repository = repository,
      super(
        ScheduleState(
          dateLabel: DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
        ),
      ) {
    _subscription = _repository.watchToday().listen(_onEntriesChanged);
  }

  void _onEntriesChanged(List<ScheduleEntry> entries) {
    final views = entries.map(_toView).toList();
    final percent = entries.isEmpty
        ? 0.0
        : entries.map((e) => e.progress).reduce((a, b) => a + b) /
              entries.length;
    emit(
      state.copyWith(
        entries: views,
        progressDisplay: '${(percent * 100).round()}%',
        progressValue: percent.clamp(0, 1),
        isLoading: false,
      ),
    );
  }

  ScheduleEntryView _toView(ScheduleEntry entry) {
    return ScheduleEntryView(
      id: entry.id,
      title: entry.title,
      type: entry.type,
      typeLabel: entry.type.labelKey.tr(),
      timeLabel: _timeLabel(entry.startTime),
      description: entry.description,
      location: entry.location,
      progress: entry.progress,
      participants: entry.participants,
      isResource: entry.type == ScheduleEntryType.resource,
    );
  }

  String _timeLabel(DateTime time) {
    final hour12 = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final period = time.hour < 12 ? 'AM' : 'PM';
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour12:$minute $period';
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
