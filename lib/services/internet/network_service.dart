// services/internet/network_service.dart

import 'dart:async';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkService {
  final _controller = StreamController<bool>.broadcast();
  Stream<bool> get connectionStream => _controller.stream;
  final InternetConnection _checker = InternetConnection();
  StreamSubscription? _subscription;
  NetworkService() {
    _init();
  }

  void _init() async {
    // Estado inicial
    final initial = await _checker.hasInternetAccess;
    _controller.add(initial);
    // Escuta mudança real de internet
    _subscription = _checker.onStatusChange.listen((status) {
      final hasInternet = status == InternetStatus.connected;
      _controller.add(hasInternet);
    });
  }

  Future<void> retry() async {
    final hasInternet = await _checker.hasInternetAccess;
    _controller.add(hasInternet);
  }

  void dispose() {
    _subscription?.cancel();
    _controller.close();
  }
}
