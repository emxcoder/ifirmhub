// services/internet/network_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'network_service.dart';

final networkServiceProvider = Provider<NetworkService>((ref) {
  final networkService = NetworkService();
  ref.onDispose(() => networkService.dispose());
  return networkService;
});

final internetStatusProvider = StreamProvider<bool>((ref) {
  final service = ref.watch(networkServiceProvider);
  return service.connectionStream;
});
