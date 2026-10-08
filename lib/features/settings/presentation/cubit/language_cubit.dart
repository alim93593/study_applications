import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/preferences_service.dart';
import 'language_state.dart';

/// Holds language selection + contextual preferences; the actual locale
/// swap is triggered by the page's BlocListener (context.setLocale).
class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit(this._prefs)
    : super(
        LanguageState(
          selectedLanguage: '',
          autoTranslate: _prefs.autoTranslate,
          regionalDate: _prefs.regionalDate,
        ),
      );

  final PreferencesService _prefs;

  void selectLanguage(String code) {
    if (state.selectedLanguage == code) return;
    emit(state.copyWith(selectedLanguage: code));
  }

  void toggleAutoTranslate(bool value) {
    emit(state.copyWith(autoTranslate: value));
    _prefs.setAutoTranslate(value);
  }

  void toggleRegionalDate(bool value) {
    emit(state.copyWith(regionalDate: value));
    _prefs.setRegionalDate(value);
  }

  void applyLanguage() =>
      emit(state.copyWith(applyToken: state.applyToken + 1));
}
