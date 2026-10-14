import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../stats/domain/entities/study_session.dart';
import '../../../stats/domain/repositories/stats_repository.dart';
import '../../../tasks/domain/repositories/subjects_repository.dart';
import 'focus_session_state.dart';

/// مؤقت جلسة التركيز: start/stop — الدقائق المحسوبة تُحفظ كـ StudySession
/// فتُضاء الإحصائيات ووقت اليوم فورًا (ستريم حي).
class FocusSessionCubit extends Cubit<FocusSessionState> {
  final StatsRepository _statsRepository;
  final SubjectsRepository _subjectsRepository;
  StreamSubscription<List<String>>? _subjectsSub;
  Timer? _ticker;

  FocusSessionCubit({
    required StatsRepository statsRepository,
    required SubjectsRepository subjectsRepository,
  }) : _statsRepository = statsRepository,
       _subjectsRepository = subjectsRepository,
       super(const FocusSessionState()) {
    _subjectsSub = _subjectsRepository.watchSubjects().listen((options) {
      emit(
        state.copyWith(
          subjectOptions: options,
          subject: state.subject.isEmpty && options.isNotEmpty
              ? options.first
              : state.subject,
        ),
      );
    });
  }

  void onSubjectSelected(String value) =>
      emit(state.copyWith(subject: value));

  void start() {
    if (state.running || state.subject.isEmpty) return;
    final now = DateTime.now();
    emit(
      state.copyWith(running: true, startedAt: now, elapsedSeconds: 0),
    );
    // الدقائق تُحسب من فرق التوقيت الحقيقي (وليس عدّ ticks) —
    // حتى لو تأخّر الـ ticker الدقيقة تفضل بالظبط.
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      final startedAt = state.startedAt;
      if (startedAt == null) return;
      emit(
        state.copyWith(
          elapsedSeconds: DateTime.now().difference(startedAt).inSeconds,
        ),
      );
    });
  }

  Future<void> stop() async {
    if (!state.running) return;
    _ticker?.cancel();
    final startedAt = state.startedAt ?? DateTime.now();
    final elapsed = DateTime.now().difference(startedAt).inSeconds;
    final minutes = (elapsed / 60).round().clamp(1, 999);
    emit(state.copyWith(running: false, elapsedSeconds: 0, startedAt: null));
    final result = await _statsRepository.addSession(
      StudySession(
        id: '',
        subject: state.subject,
        minutes: minutes,
        date: DateTime.now(),
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(failureMessage: failure.message)),
      (_) {},
    );
  }

  void clearFailure() => emit(state.copyWith(failureMessage: ''));

  @override
  Future<void> close() {
    _ticker?.cancel();
    _subjectsSub?.cancel();
    return super.close();
  }
}
