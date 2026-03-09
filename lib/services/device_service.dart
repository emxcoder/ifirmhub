import 'package:ifirmhub/services/dio_client.dart';
import '../core/models/device_model.dart';

class DeviceService {
  List<DeviceModel> listAllDevices = [];
  Future<List<DeviceModel>> fetchDevices(String type) async {
    final response = await dioBase.get('/devices');

    final devices = List<Map<String, dynamic>>.from(response.data);

    final deviceList = devices
        .where((d) =>
            d['name'].toString().contains(type) ||
            d['name'].toString().startsWith(type))
        .map((d) => DeviceModel.fromMap(d))
        .toList()
        .reversed
        .toList();
    listAllDevices.addAll(deviceList);
    return deviceList;
  }

  Future<DeviceModel> fechDeviceIdentifier(String identifier) async {
    listAllDevices.clear();
    final response = await dioBase.get('/devices');
    final devices = List<Map<String, dynamic>>.from(response.data);
    return devices
        .where((d) => d['identifier'] == identifier)
        .map((e) => DeviceModel.fromMap(e))
        .toList()
        .first;
  }
}
