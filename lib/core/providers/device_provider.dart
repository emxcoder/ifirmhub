import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/device_service.dart';
import '../models/device_model.dart';

final devicesProvider =
    FutureProvider.family<List<DeviceModel>, String>((ref, type) async {
  final service = DeviceService();
  return service.fetchDevices(type);
});
