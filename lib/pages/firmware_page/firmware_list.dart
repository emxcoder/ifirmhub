// ignore_for_file: unused_import, avoid_print, unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ifirmhub/shared/widgets/dialogs.dart';

import '../../core/models/firmware_model.dart';
import '../../services/permissions/permission_service.dart';
import 'firmware_page.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';

class FirmwareList extends StatefulWidget {
  final List<FirmwareModel> firmwares;

  const FirmwareList(this.firmwares, {super.key});

  @override
  State<FirmwareList> createState() => _FirmwareListState();
}

class _FirmwareListState extends State<FirmwareList> {
  final PermissionService permissions = PermissionService();
  final DownloadService downloadService = DownloadService();
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onResume: () {
        // permissions.checkStorage();
      },
      onPause: () => print("App Paused"),
      onHide: () => print("App Hidden"),
      // You can also handle exit requests here
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.firmwares.length,
      itemBuilder: (context, index) {
        final fw = widget.firmwares[index];

        return FirmwareCard(
          firmware: fw,
          onDownload: () async {
            await permissions.checkNotification();
            downloadService.startDownload(fw.url);

            // downloadService.pickFolder();
          },
        );
      },
    );
  }
}

class DownloadService {
  final FlutterDownloader _down = FlutterDownloader();
  static const String rootPath = '/storage/emulated/0/';
  static const String downloadPath = 'Download/iFirmHub';

  Future<String> _dirShow() async {
    final iFirmHubPath = Directory(join(rootPath, downloadPath));
    if (iFirmHubPath.existsSync()) {
      return iFirmHubPath.path;
    } else {
      await iFirmHubPath.create();
      return iFirmHubPath.path;
    }
  }

  Future<String?> pickFolder() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null) {
      // Use the path here
      showSnack(selectedDirectory);
      return selectedDirectory;
    } else {
      // User cancelled the picker
      showSnack('Cancelado');
      return null;
    }
  }

  void startDownload(String url) async {
    final savedPath = await _dirShow();
    await FlutterDownloader.enqueue(
      url: url,
      savedDir: savedPath,
      showNotification: true,
    ).then((value) => showSnack('"${basename(url)}" - Baixando...'));
  }

  void cancelAll() async {
    try {
      await FlutterDownloader.cancelAll();
      showSnack('Tudo Cancelado');
    } catch (e) {
      showSnack('Erro ao Cancelar... $e');
    }
  }
}
