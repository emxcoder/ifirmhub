import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/device_model.dart';
import '../../core/models/products_model.dart';
import '../../core/providers/device_provider.dart';
import '../../services/internet/network_provider.dart';
import '../../shared/widgets/appbars.dart';
import '../../shared/widgets/texts.dart';
import 'device_card.dart';

class DevicePage extends ConsumerWidget {
  final ProductModel? productModel;
  final String type;
  const DevicePage({
    super.key,
    required this.type,
    this.productModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pOnline = ProductModel(id: '9', name: type, imageUrl: '');
    final internetCheck = ref.watch(internetStatusProvider);
    bool status = internetCheck.value != null && internetCheck.value == true;

    final productModeltoUse = productModel ?? pOnline;

    final devices = ref.watch(devicesProvider(productModeltoUse.name));
    return Scaffold(
      appBar: topAppBar,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              chooseDText,
              devices.isLoading || !status
                  ? LinearProgressIndicator()
                  : Visibility(visible: false, child: Text('')),
              devices.when(
                data: (listDevices) {
                  return DevicesView(
                    devices: listDevices,
                    productModel: productModeltoUse,
                  );
                },
                error: (error, stackTrace) {
                  return Text('Erro $error');
                },
                loading: () {
                  return Visibility(
                    visible: false,
                    child: Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Center(
                            child: CircularProgressIndicator(),
                          )),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DevicesView extends ConsumerWidget {
  const DevicesView(
      {super.key, required this.devices, required this.productModel});
  final List<DeviceModel> devices;
  final ProductModel productModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final internetCheck = ref.watch(internetStatusProvider);
    bool status = internetCheck.value != null && internetCheck.value == true;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: RefreshIndicator(
          onRefresh: () {
            final newValue = ref.refresh(internetStatusProvider.future);
            return newValue;
          },
          child: GridView.builder(
            itemCount: devices.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  MediaQuery.of(context).size.width > 600 ? 4 : 2, // 2 colunas
              crossAxisSpacing: 2,
              mainAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              final deviceModel = devices[index];

              if (!status) {
                return Card();
              }
              return DeviceCard(deviceModel: deviceModel);
            },
          ),
        ),
      ),
    );
  }
}
