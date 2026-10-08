import 'package:flutter/material.dart';

import '../di/service_locator.dart';
import '../services/connectivity_service.dart';
import 'network_handler.dart';

/// فحص الاتصال على مستوى الراوتر: يلفّ الشاشات المعتمدة على Firestore
/// ويعرض حالة "لا اتصال" مع إعادة المحاولة بدل ما الصفحة تفشل بصمت.
/// Why StatefulWidget: فحص غير متزامن في دورة الحياة (flutter_hooks ممنوع).
class ConnectivityGuard extends StatefulWidget {
  final Widget child;

  const ConnectivityGuard({super.key, required this.child});

  @override
  State<ConnectivityGuard> createState() => _ConnectivityGuardState();
}

class _ConnectivityGuardState extends State<ConnectivityGuard> {
  bool? _isConnected; // null = قيد الفحص

  @override
  void initState() {
    super.initState();
    _check();
  }

  Future<void> _check() async {
    final connected = await sl<ConnectivityService>().isConnected;
    if (mounted) setState(() => _isConnected = connected);
  }

  @override
  Widget build(BuildContext context) {
    if (_isConnected == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_isConnected!) return widget.child;
    return Scaffold(body: NoInternetWidget(onRetry: _check));
  }
}
