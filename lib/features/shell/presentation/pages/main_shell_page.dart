import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigator/app_navigator.dart';
import '../../../../core/widgets/app_bottom_nav.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../../../../core/widgets/app_top_bar.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../schedule/presentation/pages/schedule_page.dart';
import '../../../stats/presentation/pages/stats_page.dart';
import '../../../tasks/presentation/pages/tasks_page.dart';

/// الهيكل الرئيسي للتطبيق: شريط علوي + أربعة تبويبات + بوتون ناف.
/// Why: التنقل بين التبويبات عبر pushReplacement لمعامل الراوتر —
/// بلا setState ولا hooks (Stateless بالكامل).
class MainShellPage extends StatelessWidget {
  final int initialIndex;

  const MainShellPage({super.key, this.initialIndex = 0});

  static const List<Widget> _tabs = [
    HomePage(),
    TasksPage(),
    SchedulePage(),
    StatsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final index = initialIndex.clamp(0, _tabs.length - 1);
    // الخروج (signOut) يتطلب توجيهًا لشاشة الدخول — عبر BlocListener.
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, curr) =>
          curr.status == AuthStatus.unauthenticated &&
          prev.status == AuthStatus.loading,
      listener: (context, state) =>
          AppNavigator.pushReplacement(AppNavigator.login),
      child: Scaffold(
        drawer: const AppDrawer(),
        body: SafeArea(
          child: Column(
            children: [
              const AppTopBar(),
              Expanded(
                child: IndexedStack(index: index, children: _tabs),
              ),
              AppBottomNav(currentIndex: index),
            ],
          ),
        ),
      ),
    );
  }
}
