import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../localization/app_strings.dart';
import 'network_handler.dart';

class NetworkWrapper extends HookWidget {
  final Widget child;

  const NetworkWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isConnected = useState(true);

    useEffect(() {
      final subscription =
          NetworkHandler().connectionStream.listen((connected) {
        isConnected.value = connected;
      });
      return subscription.cancel;
    }, []);

    if (!isConnected.value) {
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
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppStrings.checkConnectionMessage.tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    isConnected.value =
                        await NetworkHandler().checkConnection();
                  },
                  child: Text(AppStrings.retry.tr()),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return child;
  }
}
