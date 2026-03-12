import '../core/models/firmware_model.dart';
import 'dio_client.dart';

class FirmwareService {
  Future<List<FirmwareModel>> fetchFirmwares(String identifier, String type) async {
    final response = await dioBase
        .get('/device/$identifier', queryParameters: {'type': type});

    final list = List<Map<String, dynamic>>.from(response.data['firmwares']);

    return list.map((e) => FirmwareModel.fromMap(e)).toList();
  }
}
