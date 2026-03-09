import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/device_service.dart';
import '../models/device_model.dart';

final devicesbyIdProvider =
    FutureProvider.family<DeviceModel, String>((ref, identifier) async {
  final service = DeviceService();
  return service.fechDeviceIdentifier(identifier);
});
