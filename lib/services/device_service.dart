import 'package:ifirmhub/services/dio_client.dart';
import '../core/models/device_model.dart';

class DeviceService {
  Future<List<DeviceModel>> fetchDevices(String type) async {
    final response = await dioBase.get('/devices');

    final devices = List<Map<String, dynamic>>.from(response.data);
    return devices
        .where((d) =>
            d['name'].toString().contains(type) ||
            d['name'].toString().startsWith(type))
        .map((d) => DeviceModel.fromMap(d))
        .toList()
        .reversed
        .toList();
  }
}
