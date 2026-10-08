import 'package:equatable/equatable.dart';

class LanguageState extends Equatable {
  const LanguageState({
    required this.selectedLanguage,
    required this.autoTranslate,
    required this.regionalDate,
    this.applyToken = 0,
  });

  final String selectedLanguage;
  final bool autoTranslate;
  final bool regionalDate;

  /// Increments on every "Apply" press — BlocListener watches it so the
  /// locale side effect stays out of the widgets (Zero UI Logic).
  final int applyToken;

  LanguageState copyWith({
    String? selectedLanguage,
    bool? autoTranslate,
    bool? regionalDate,
    int? applyToken,
  }) {
    return LanguageState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      autoTranslate: autoTranslate ?? this.autoTranslate,
      regionalDate: regionalDate ?? this.regionalDate,
      applyToken: applyToken ?? this.applyToken,
    );
  }

  @override
  List<Object?> get props => [
    selectedLanguage,
    autoTranslate,
    regionalDate,
    applyToken,
  ];
}
