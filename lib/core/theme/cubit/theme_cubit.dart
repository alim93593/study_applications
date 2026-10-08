import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'theme_state.dart';

import '../../services/preferences_service.dart';
import 'theme_state.dart';

/// App-wide theme state (allowed in main.dart per AGENTS — Theme exception).
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(this._prefs) : super(ThemeState(mode: _parse(_prefs.themeMode)));

  final PreferencesService _prefs;

  static ThemeMode _parse(String value) => switch (value) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };

  void setMode(ThemeMode mode) {
    emit(state.copyWith(mode: mode));
    _prefs.setThemeMode(mode.name);
  }
}
