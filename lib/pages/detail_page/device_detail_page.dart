import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ifirmhub/constants/constants.dart';
import 'package:ifirmhub/core/providers/detail_provider.dart';
import 'package:ifirmhub/core/utils/utils.dart';
import 'package:ifirmhub/shared/widgets/appbars.dart';

import '../../core/models/device_model.dart';
import '../../services/internet/network_provider.dart';
import 'info_row.dart';

class DeviceDetailsPage extends ConsumerWidget {
  final String identifierRoute;
  final DeviceModel? deviceModelLocal;

  const DeviceDetailsPage({
    super.key,
    required this.identifierRoute,
    this.deviceModelLocal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Aqui você pode futuramente buscar detalhes extras pela API
    // Por enquanto vamos simular
    final internetCheck = ref.watch(internetStatusProvider);
    bool status = internetCheck.value != null && internetCheck.value == true;

    final String identifier = deviceModelLocal?.identifier ?? identifierRoute;
    final deviceModel = ref.watch(devicesbyIdProvider(identifier));

    return Scaffold(
      appBar: topAppBar,
      body: SafeArea(
        child: Stack(
          children: [
            if (!status) LinearProgressIndicator(),
            deviceModel.when(
              data: (data) {
                return Padding(
                  padding: const EdgeInsets.all(18),
                  child: MediaQuery.of(context).size.width > 600
                      ? LandscapeStyle(
                          deviceModel: data, identifier: identifier)
                      : PortraitStyle(
                          deviceModel: data, identifier: identifier),
                );
              },
              error: (error, stackTrace) {
                return Text('Error');
              },
              loading: () {
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PortraitStyle extends StatelessWidget {
  const PortraitStyle({
    super.key,
    required this.deviceModel,
    required this.identifier,
  });

  final DeviceModel deviceModel;
  final String identifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 Header
        Header(deviceModel: deviceModel),

        const SizedBox(height: 5),
        const Divider(),
        const SizedBox(height: 5),

        /// 🔹 Informações Técnicas (placeholder)
        const Text(
          'Device Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        InfoRow(label: 'Identifier', value: deviceModel.identifier),
        InfoRow(label: 'BoardConfig', value: deviceModel.boardconfig),
        InfoRow(label: 'Platform', value: deviceModel.platform),
        InfoRow(label: 'Cpid', value: deviceModel.cpid.toString()),
        InfoRow(label: 'Bdid', value: deviceModel.bdid.toString()),
        Spacer(),

        /// 🔹 Botão Principal
        FirmwareButton(identifier: identifier),

        const SizedBox(height: 10),
      ],
    );
  }
}

class LandscapeStyle extends StatelessWidget {
  const LandscapeStyle({
    super.key,
    required this.deviceModel,
    required this.identifier,
  });

  final DeviceModel deviceModel;
  final String identifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// 🔹 Header
        Expanded(child: FittedBox(child: Header(deviceModel: deviceModel))),

        // const SizedBox(width: 5),
        const VerticalDivider(),
        // const SizedBox(width: 5),

        /// 🔹 Informações Técnicas (placeholder)

        Flexible(
          child: SizedBox(
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Device Information',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InfoRow(label: 'Identifier', value: deviceModel.identifier),
                InfoRow(label: 'BoardConfig', value: deviceModel.boardconfig),
                InfoRow(label: 'Platform', value: deviceModel.platform),
                InfoRow(label: 'Cpid', value: deviceModel.cpid.toString()),
                InfoRow(label: 'Bdid', value: deviceModel.bdid.toString()),
              ],
            ),
          ),
        ),
        const VerticalDivider(),
        Flexible(child: FirmwareButton(identifier: identifier))
        // const SizedBox(width: 16),

        /// 🔹 Botão Principal
        // FirmwareButton(identifier: identifier),
      ],
    );
  }
}

class FirmwareButton extends ConsumerWidget {
  const FirmwareButton({
    super.key,
    required this.identifier,
  });

  final String identifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          if (!hasInternetGlobal(ref)) {
            counterTryState(ref).state++;
            notificationService.showOffline(context);
          } else {
            context.push('/firmwares/$identifier');
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: const Text(
          'View Firmwares',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.deviceModel,
  });

  final DeviceModel deviceModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Hero(
            tag: deviceModel.identifier,
            transitionOnUserGestures: true,
            child: Image.network(deviceModel.url)),
        const SizedBox(height: 8),
        Text(
          deviceModel.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          deviceModel.identifier,
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
