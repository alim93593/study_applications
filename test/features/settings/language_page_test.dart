import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_for_ever/core/services/preferences_service.dart';
import 'package:study_for_ever/features/settings/presentation/cubit/language_cubit.dart';
import 'package:study_for_ever/features/settings/presentation/pages/language_page.dart';
import 'package:study_for_ever/features/settings/presentation/widgets/language_card.dart';

/// Regression: LanguagePage used to crash with "Tried to listen to an
/// InheritedWidget in a life-cycle that will never be called again" because
/// `ctx.locale` (Provider, listen: true) was read inside BlocProvider.create.
/// The page must mount, select a language, and apply it without exceptions.
void main() {
  final sl = GetIt.instance;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    // Initializes the static device/saved locale (required by
    // EasyLocalizationController; otherwise _deviceLocale throws LateError).
    await EasyLocalization.ensureInitialized();
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    sl.registerSingleton<PreferencesService>(PreferencesService(prefs));
    sl.registerFactory<LanguageCubit>(() => LanguageCubit(sl()));
  });

  tearDown(() async => sl.reset());

  Future<void> pumpLanguagePage(WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('ar'), Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar'),
        child: Builder(
          builder: (context) => MaterialApp(
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            home: const LanguagePage(),
          ),
        ),
      ),
    );
    // Translation JSON loads via real file IO — give it real async time
    // before settling the fake test clock.
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 100)),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('mounts without provider-lifecycle crash', (tester) async {
    await pumpLanguagePage(tester);

    expect(find.byType(LanguageCard), findsNWidgets(2));
  });

  testWidgets('selecting English and applying swaps the locale', (
    tester,
  ) async {
    await pumpLanguagePage(tester);

    debugPrint('DIAG LanguagePage=${find.byType(LanguagePage).evaluate().length} '
        'LanguageCard=${find.byType(LanguageCard).evaluate().length} '
        'EasyLoc=${find.byType(EasyLocalization).evaluate().length} '
        'Texts=${find.byType(Text).evaluate().length}');
    await tester.tap(find.byType(LanguageCard).first);
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byIcon(Icons.check_rounded));
    await tester.tap(find.byIcon(Icons.check_rounded));
    // setLocale loads en.json asynchronously — real async time again.
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 100)),
    );
    await tester.pumpAndSettle();

    final ctx = tester.element(find.byType(LanguagePage));
    expect(ctx.locale.languageCode, 'en');
  });
}
