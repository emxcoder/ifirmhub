import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/internet/network_provider.dart';

bool hasInternetGlobal(WidgetRef ref) {
  final internetCheck = ref.watch(internetStatusProvider);
  final status = internetCheck.value != null && internetCheck.value == true;
  return status;
}

int counterTry(WidgetRef ref) {
  return ref.watch(counterProvider);
}

StateController<int> counterTryState(WidgetRef ref) {
  return ref.read(counterProvider.notifier);
}
