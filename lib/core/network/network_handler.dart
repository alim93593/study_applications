import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../localization/app_strings.dart';
import '../theme/app_text_styles.dart';

class NetworkHandler {
  static final NetworkHandler _instance = NetworkHandler._internal();
  factory NetworkHandler() => _instance;
  NetworkHandler._internal();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  final StreamController<bool> _connectionController =
      StreamController<bool>.broadcast();

  Stream<bool> get connectionStream => _connectionController.stream;

  void initialize() {
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      final isConnected = results.any(
        (result) => result != ConnectivityResult.none,
      );
      _connectionController.add(isConnected);
    });
  }

  Future<bool> checkConnection() async {
    final results = await _connectivity.checkConnectivity();
    return results.any((result) => result != ConnectivityResult.none);
  }

  void dispose() {
    _subscription?.cancel();
    _connectionController.close();
  }
}

class NoInternetWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
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
              onPressed: onRetry,
              child: Text(AppStrings.retry.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
