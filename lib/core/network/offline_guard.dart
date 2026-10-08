import '../error/failures.dart';
import '../localization/app_strings.dart';
import '../services/connectivity_service.dart';

/// Offline short-circuit for repositories — no request is sent while offline.
/// Why: shared helper so every repository stays under the 100-line limit.
/// Returns the failure to emit, or null when online.
Future<Failure?> offlineFailure(ConnectivityService connectivity) async {
  if (await connectivity.isConnected) return null;
  return ServerFailure(AppStrings.noInternetConnection);
}
