import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/preferences_service.dart';
import 'settings_state.dart';

/// Settings-screen preferences that outlive the page (persisted).
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._prefs)
    : super(SettingsState(deepFocus: _prefs.deepFocus));

  final PreferencesService _prefs;

  void toggleDeepFocus(bool value) {
    emit(state.copyWith(deepFocus: value));
    _prefs.setDeepFocus(value);
  }
}
