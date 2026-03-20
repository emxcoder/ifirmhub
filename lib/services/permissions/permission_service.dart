import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  final _permissionStorage = Permission.manageExternalStorage;

  void checkStorage() async {
    final isGranted = await _permissionStorage.isGranted;
    final isPermanentDenied = await _permissionStorage.isPermanentlyDenied;
    if (isGranted) {
    } else if (isPermanentDenied) {
      await openAppSettings();
    } else {
      await _permissionStorage.request();
    }
  }
}
