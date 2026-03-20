import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ifirmhub/core/models/device_model.dart';
import 'package:ifirmhub/core/models/firmware_model.dart';
import 'package:ifirmhub/core/providers/firmware_provider.dart';
import 'package:intl/intl.dart';

import '../../core/providers/detail_provider.dart';

class FirmwarePage extends ConsumerStatefulWidget {
  final DeviceModel? deviceModelLocal;
  final String identifierRoute;
  const FirmwarePage(
      {super.key,
      required this.deviceModelLocal,
      required this.identifierRoute});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FirmwarePageState();
}

class _FirmwarePageState extends ConsumerState<FirmwarePage> {
  String type = 'ipsw';
  @override
  Widget build(BuildContext context) {
    final nameToUse =
        widget.deviceModelLocal?.identifier ?? widget.identifierRoute;

    final firmware = ref.watch(firmwaresProvider.call(nameToUse, type));

    final deviceModel = ref.watch(devicesbyIdProvider(nameToUse));

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: deviceModel.when(
            error: (error, stackTrace) => Text(nameToUse),
            loading: () => Icon(
              Icons.phone_iphone,
              size: 35,
            ),
            data: (data) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: deviceModel,
                  child: Image.network(
                    data.url,
                    width: 35,
                    height: 35,
                  ),
                ),
                Expanded(child: Text(data.name, style: TextStyle(fontSize: 18),)),
              ],
            ),
          ),
          
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: "All"),
              Tab(text: "Signed"),
              Tab(text: "Unsigned"),
            ],
          ),
        ),
        body: firmware.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text(e.toString())),
          data: (firmwares) {
            final signedFirm =
                firmwares.where((f) => f.signed).map((e) => e).toList();
            final unsignedFirm =
                firmwares.where((f) => !f.signed).map((e) => e).toList();

            return Stack(
              children: [
                TabBarView(
                  children: [
                    FirmwareList(firmwares),
                    FirmwareList(signedFirm),
                    FirmwareList(unsignedFirm),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class FirmwareList extends StatelessWidget {
  final List<FirmwareModel> firmwares;

  const FirmwareList(this.firmwares, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: firmwares.length,
      itemBuilder: (context, index) {
        final fw = firmwares[index];

        return FirmwareCard(
          firmware: fw,
          onDownload: () {
            context.push(
              '/download',
              extra: fw,
            );
          },
        );
      },
    );
  }
}

class FirmwareCard extends StatelessWidget {
  final FirmwareModel firmware;
  final VoidCallback onDownload;

  const FirmwareCard({
    super.key,
    required this.firmware,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Colors.blue),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                titleVersion(firmware.signed),
                _SignedBadge(firmware.signed),
              ],
            ),

            const SizedBox(height: 10),
            _info("Identifier", firmware.identifier),
            _info("BuilId", firmware.buildid),
            _info("Release", _formatDate(firmware)),
            _info("FileSize", _formatSize(firmware.filesize)),
            _infoFirm("Firm", firmware.url.split('/').last),

            const SizedBox(height: 14),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: onDownload,
                icon: const Icon(Icons.download),
                label: const Text("Download"),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextButton titleVersion(bool signed) {
    final Color color = signed ? Colors.green : Colors.red;
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(
        signed ? Icons.done : Icons.close,
        color: color,
      ),
      label: Text(
        "iOS ${firmware.version}",
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _infoFirm(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  String _formatSize(int bytes) {
    final gb = bytes / (1024 * 1024 * 1024);
    return "${gb.toStringAsFixed(2)} GB";
  }
}

String _formatDate(FirmwareModel model) {
  final dataApi = model.releasedate;
  // 1. Converte a String para DateTime
  if (dataApi == null) {
    return '--no info--';
  }

  // 2. Extrai o dia para calcular o sufixo
  int dia = dataApi.day;
  String sufixo = 'th';
  if (!(dia >= 11 && dia <= 13)) {
    switch (dia % 10) {
      case 1:
        sufixo = 'st';
        break;
      case 2:
        sufixo = 'nd';
        break;
      case 3:
        sufixo = 'rd';
        break;
    }
  }

  // 3. Formata o restante (Mês e Ano)
  String mesEAno = DateFormat('MMMM yyyy').format(dataApi);

  return '$dia$sufixo $mesEAno';
}

class _SignedBadge extends StatelessWidget {
  final bool signed;

  const _SignedBadge(this.signed);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: signed ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        signed ? "SIGNED" : "UNSIGNED",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
