import 'package:equatable/equatable.dart';

class FocusSessionState extends Equatable {
  final List<String> subjectOptions;
  final String subject;
  final bool running;
  final DateTime? startedAt;
  final int elapsedSeconds;
  final String failureMessage;

  const FocusSessionState({
    this.subjectOptions = const [],
    this.subject = '',
    this.running = false,
    this.startedAt,
    this.elapsedSeconds = 0,
    this.failureMessage = '',
  });

  String get elapsedDisplay {
    final m = (elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  FocusSessionState copyWith({
    List<String>? subjectOptions,
    String? subject,
    bool? running,
    DateTime? startedAt,
    int? elapsedSeconds,
    String? failureMessage,
  }) {
    return FocusSessionState(
      subjectOptions: subjectOptions ?? this.subjectOptions,
      subject: subject ?? this.subject,
      running: running ?? this.running,
      startedAt: startedAt ?? this.startedAt,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [
    subjectOptions,
    subject,
    running,
    startedAt,
    elapsedSeconds,
    failureMessage,
  ];
}
