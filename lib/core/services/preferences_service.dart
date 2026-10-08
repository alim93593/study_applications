import 'package:shared_preferences/shared_preferences.dart';

/// Unified SharedPreferences access (AGENTS rule: no direct prefs usage
/// anywhere else). Values are read synchronously after [init] so the UI and
/// cubits never await storage.
class PreferencesService {
  PreferencesService(this._prefs);

  final SharedPreferences _prefs;

  static const _kThemeMode = 'theme_mode';
  static const _kAutoTranslate = 'auto_translate';
  static const _kRegionalDate = 'regional_date';
  static const _kDeepFocus = 'deep_focus';
  static const _kSubjectsSeeded = 'subjects_seeded';

  String get themeMode => _prefs.getString(_kThemeMode) ?? 'system';
  Future<void> setThemeMode(String value) =>
      _prefs.setString(_kThemeMode, value);

  bool get autoTranslate => _prefs.getBool(_kAutoTranslate) ?? false;
  Future<void> setAutoTranslate(bool value) =>
      _prefs.setBool(_kAutoTranslate, value);

  bool get regionalDate => _prefs.getBool(_kRegionalDate) ?? true;
  Future<void> setRegionalDate(bool value) =>
      _prefs.setBool(_kRegionalDate, value);

  bool get deepFocus => _prefs.getBool(_kDeepFocus) ?? false;
  Future<void> setDeepFocus(bool value) => _prefs.setBool(_kDeepFocus, value);

  bool get subjectsSeeded => _prefs.getBool(_kSubjectsSeeded) ?? false;
  Future<void> setSubjectsSeeded(bool value) =>
      _prefs.setBool(_kSubjectsSeeded, value);
}
