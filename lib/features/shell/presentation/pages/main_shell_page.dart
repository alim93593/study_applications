import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/widgets/app_bottom_nav.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../../../../core/widgets/app_top_bar.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../schedule/presentation/pages/schedule_page.dart';
import '../../../stats/presentation/pages/stats_page.dart';
import '../../../tasks/presentation/pages/tasks_page.dart';
import '../cubit/shell_cubit.dart';

/// الهيكل الرئيسي: تبويب واحد حيّ (ShellCubit + IndexedStack).
/// Why: pushReplacement كان يهدم الشل ويبنيه من جديد مع كل tap → التايمر
/// يموت والصفحات تعيد تحميل Firestore كل مرة (بطء + فقدان الجلسة).
/// الاختيار يحدث في AppRouter مرة واحدة فقط.
class MainShellPage extends StatelessWidget {
  const MainShellPage({super.key});

  static const List<Widget> _tabs = [
    HomePage(),
    TasksPage(),
    SchedulePage(),
    StatsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // Why: لا نستدعي select هنا — إعادة بناء الشل (ثيم/لغة) كانت بترجّع
    // التبويب لـ 0 وتقتل الجلسة. الاختيار يحصل مرة واحدة في AppRouter فقط.
    final shellCubit = sl<ShellCubit>();
    // الخروج (signOut) يتطلب توجيهًا لشاشة الدخول — عبر BlocListener.
    return BlocProvider<ShellCubit>.value(
      value: shellCubit,
      child: BlocListener<AuthCubit, AuthState>(
        listenWhen: (prev, curr) =>
            curr.status == AuthStatus.unauthenticated &&
            prev.status == AuthStatus.loading,
        listener: (context, state) =>
            AppNavigator.pushReplacement(AppNavigator.login),
        child: Scaffold(
          drawer: const AppDrawer(),
          body: Stack(
            children: [
              SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    const AppTopBar(),
                    Expanded(
                      child: BlocSelector<ShellCubit, ShellState, int>(
                        selector: (s) => s.index,
                        builder: (context, index) =>
                            IndexedStack(index: index, children: _tabs),
                      ),
                    ),
                  ],
                ),
              ),
              // الناف الزجاجي فوق المحتوى — السكرول يمرق تحته فيتموّه.
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: BlocSelector<ShellCubit, ShellState, int>(
                  selector: (s) => s.index,
                  builder: (context, index) =>
                      AppBottomNav(currentIndex: index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
