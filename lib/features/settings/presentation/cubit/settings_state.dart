import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  const SettingsState({required this.deepFocus});

  final bool deepFocus;

  SettingsState copyWith({bool? deepFocus}) =>
      SettingsState(deepFocus: deepFocus ?? this.deepFocus);

  @override
  List<Object?> get props => [deepFocus];
}
