import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShellState extends Equatable {
  final int index;

  const ShellState({this.index = 0});

  ShellState copyWith({int? index}) =>
      ShellState(index: index ?? this.index);

  @override
  List<Object?> get props => [index];
}

/// التبويب النشط في الشل (Focus/Tasks/Schedule/Stats).
/// Why: pushReplacement كان يعيد بناء الشل كاملًا → التايمر يموت والتنقل
/// بطيء؛ Cubit واحد حي يبدّل التبويب في مكانه فقط (IndexedStack).
class ShellCubit extends Cubit<ShellState> {
  ShellCubit() : super(const ShellState());

  void select(int index) {
    if (index == state.index) return;
    emit(state.copyWith(index: index));
  }
}
