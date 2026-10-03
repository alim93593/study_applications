import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../splash_effects.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';

/// Wraps the splash tree with the auth BlocListener that schedules the final
/// redirect — keeps splash_page within the 100-line rule.
class SplashRedirect extends StatelessWidget {
  const SplashRedirect({
    super.key,
    required this.lastStatus,
    required this.child,
  });

  final ValueNotifier<AuthStatus?> lastStatus;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, curr) =>
          curr.status == AuthStatus.authenticated ||
          curr.status == AuthStatus.unauthenticated,
      listener: (context, state) => scheduleSplashRedirect(
        context: context,
        lastStatus: lastStatus,
        status: state.status,
      ),
      child: child,
    );
  }
}
