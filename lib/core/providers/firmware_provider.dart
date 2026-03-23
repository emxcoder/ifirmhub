import 'package:ifirmhub/core/models/firmware_model.dart';
import 'package:ifirmhub/services/firmware_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firmware_provider.g.dart';

@riverpod
Future<List<FirmwareModel>> firmwares(Ref ref, String identifier, String type) {
  final service = FirmwareService();

  return service.fetchFirmwares(identifier, type);
}
