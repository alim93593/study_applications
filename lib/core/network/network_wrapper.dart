import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../localization/app_strings.dart';
import '../theme/app_text_styles.dart';
import 'network_handler.dart';

/// Owns the connectivity subscription — StatefulWidget is the necessary
/// exception (stream lifecycle); flutter_hooks is banned project-wide.
class NetworkWrapper extends StatefulWidget {
  const NetworkWrapper({super.key, required this.child});

  final Widget child;

  @override
  State<NetworkWrapper> createState() => _NetworkWrapperState();
}

class _NetworkWrapperState extends State<NetworkWrapper> {
  late final StreamSubscription<bool> _subscription;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _subscription = NetworkHandler().connectionStream.listen((connected) {
      if (mounted) setState(() => _isConnected = connected);
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future<void> _retry() async {
    final connected = await NetworkHandler().checkConnection();
    if (mounted) setState(() => _isConnected = connected);
  }

  @override
  Widget build(BuildContext context) {
    if (_isConnected) return widget.child;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
              const SizedBox(height: 24),
              Text(
                AppStrings.noInternetConnection.tr(),
                style: AppTextStyles.titleNetwork,
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.checkConnectionMessage.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyNetwork,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _retry,
                child: Text(AppStrings.retry.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
