// services/internet/network_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'network_service.dart';
part 'network_provider.g.dart';

@riverpod
NetworkService networkService(Ref ref) {
  final networkService = NetworkService();
  ref.onDispose(() => networkService.dispose());
  return networkService;
}

@riverpod
Stream<bool> internetStatus(Ref ref) {
  final service = ref.watch(networkServiceProvider);
  return service.connectionStream;
}
