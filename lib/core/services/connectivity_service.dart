import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

/// خدمة فحص الاتصال بالإنترنت (DI: سجلّها في service_locator).
/// Why: فحص حقيقي للإنترنت (مش بس وجود شبكة) عبر باكدج
/// internet_connection_checker المصادق عليه في AGENTS.md.
abstract class ConnectivityService {
  /// هل يوجد إنترنت فعلي الآن؟
  Future<bool> get isConnected;

  /// بث حي لتغيّرات الاتصال (شبكة + فحص حقيقي).
  Stream<bool> get connectionStream;
}

class ConnectivityServiceImpl implements ConnectivityService {
  final InternetConnectionChecker _checker;
  final Connectivity _connectivity;

  ConnectivityServiceImpl({
    InternetConnectionChecker? checker,
    Connectivity? connectivity,
  }) : _checker = checker ?? InternetConnectionChecker.createInstance(),
       _connectivity = connectivity ?? Connectivity();

  @override
  Future<bool> get isConnected => _checker.hasConnection;

  @override
  Stream<bool> get connectionStream async* {
    await for (final results in _connectivity.onConnectivityChanged) {
      final hasNetwork = results.any((r) => r != ConnectivityResult.none);
      yield hasNetwork && await _checker.hasConnection;
    }
  }
}
