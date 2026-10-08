import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/di/service_locator.dart' as di;
import 'core/localization/app_strings.dart';
import 'core/navigator/app_navigator.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/localization/app_localizations.dart';
import 'core/network/network_handler.dart';
import 'core/network/network_wrapper.dart';
import 'core/theme/cubit/theme_cubit.dart';
import 'core/utils/system_ui.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  NetworkHandler().initialize();

  applySystemUiStyle(Brightness.light);

  runApp(
    EasyLocalization(
      supportedLocales: AppLocalizations.supportedLocales,
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => di.sl<AuthCubit>()),
        BlocProvider<ThemeCubit>(create: (_) => di.sl<ThemeCubit>()),
      ],
      child: NetworkWrapper(
        child: BlocSelector<ThemeCubit, ThemeState, ThemeMode>(
          selector: (state) => state.mode,
          builder: (context, themeMode) {
            return MaterialApp(
              navigatorKey: AppNavigator.navigatorKey,
              title: AppStrings.appName.tr(),
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              initialRoute: AppRouter.splash,
              onGenerateRoute: AppRouter.onGenerateRoute,
              builder: (context, child) {
                final brightness = themeMode == ThemeMode.system
                    ? MediaQuery.platformBrightnessOf(context)
                    : themeMode == ThemeMode.dark
                    ? Brightness.dark
                    : Brightness.light;
                applySystemUiStyle(brightness);
                return child!;
              },
            );
          },
        ),
      ),
    );
  }
}
