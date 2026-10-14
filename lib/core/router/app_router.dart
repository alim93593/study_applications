import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/settings/presentation/pages/language_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/shell/presentation/cubit/shell_cubit.dart';
import '../../features/shell/presentation/pages/main_shell_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/tasks/domain/entities/task_entity.dart';
import '../../features/tasks/presentation/pages/new_task_page.dart';
import '../di/service_locator.dart';
import '../widgets/dark_screen_overlay.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';

  // New screens (8 Figma screens)
  static const String shell = '/shell';
  static const String tasks = '/tasks';
  static const String newTask = '/new-task';
  static const String schedule = '/schedule';
  static const String subject = '/subject';
  static const String stats = '/stats';
  static const String setting = '/settings';
  static const String language = '/language';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case login:
        return MaterialPageRoute(
          builder: (_) =>
              const DarkScreenOverlay(child: LoginPage()),
        );
      case register:
        return MaterialPageRoute(
          builder: (_) =>
              const DarkScreenOverlay(child: RegisterPage()),
        );
      case forgotPassword:
        return MaterialPageRoute(
          builder: (_) =>
              const DarkScreenOverlay(child: ForgotPasswordPage()),
        );
      case home:
      case shell:
        // اختيار التبويب مرة واحدة هنا — لا في build عشان إعادة البناء
        // (ثيم/لغة) ما ترجّعش التبويب لـ 0.
        sl<ShellCubit>().select((settings.arguments as int?) ?? 0);
        // settings ضرورية عشان route.settings.name يتسجل (popUntil يعتمد عليه).
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const MainShellPage(),
        );
      case tasks:
        sl<ShellCubit>().select(1);
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const MainShellPage(),
        );
      case schedule:
        sl<ShellCubit>().select(2);
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const MainShellPage(),
        );
      case stats:
        sl<ShellCubit>().select(3);
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const MainShellPage(),
        );
      case newTask:
        return MaterialPageRoute(
          builder: (_) =>
              NewTaskPage(task: settings.arguments as TaskEntity?),
        );
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfilePage());
      case setting:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      case language:
        return MaterialPageRoute(builder: (_) => const LanguagePage());
      default:
        return MaterialPageRoute(builder: (_) => const SplashPage());
    }
  }
}
