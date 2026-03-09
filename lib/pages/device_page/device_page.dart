import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/router/routes.dart';
import '../../constants/constants.dart';
import '../../core/models/device_model.dart';
import '../../core/models/products_model.dart';
import '../../core/providers/device_provider.dart';
import '../../core/utils/utils.dart';
import '../../shared/widgets/appbars.dart';
import '../../shared/widgets/texts.dart';
import 'device_card.dart';

class DevicePage extends ConsumerStatefulWidget {
  final ProductModel? productModelLocal;
  final String typePath;
  const DevicePage({
    super.key,
    required this.typePath,
    this.productModelLocal,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DevicePageState();
}

class _DevicePageState extends ConsumerState<DevicePage> {
  @override
  Widget build(BuildContext context) {
    final hasInternet = hasInternetGlobal(ref);
    final productModeltoUse = widget.productModelLocal?.name ?? widget.typePath;
    final devices = ref.watch(devicesProvider(productModeltoUse));

    return Scaffold(
      appBar: topAppBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          chooseDText,
          if (!hasInternet) LinearProgressIndicator(),
          !hasInternet
              ? GridOff()
              : devices.when(
                  data: (listDevices) {
                    return DevicesView(
                        devices: listDevices, namePath: productModeltoUse);
                  },
                  error: (error, stackTrace) {
                    return Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Erro no Carregamento!',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 40),
                            ),
                            ElevatedButton.icon(
                                onPressed: () async {
                                  return await ref.refresh(
                                      devicesProvider(productModeltoUse)
                                          .future);
                                },
                                icon: Icon(Icons.refresh),
                                label: Text('Tentar Novamente'))
                          ],
                        ),
                      ),
                    );
                  },
                  loading: () {
                    return Expanded(
                        child: Center(
                      child: CircularProgressIndicator(),
                    ));
                  },
                )
        ],
      ),
    );
  }
}

class DevicesView extends ConsumerWidget {
  const DevicesView({super.key, required this.devices, required this.namePath});
  final List<DeviceModel> devices;
  final String namePath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasInternet = hasInternetGlobal(ref);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: RefreshIndicator(
          onRefresh: () async {
            return await ref.refresh(devicesProvider(namePath).future);
          },
          child: GridView.builder(
            itemCount: !hasInternet ? 30 : devices.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  MediaQuery.of(context).size.width > 600 ? 4 : 2, // 2 colunas
              crossAxisSpacing: 2,
              mainAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              final deviceModel = devices[index];
              return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  splashColor: Colors.blueAccent,
                  onLongPress: () {},
                  onTap: () {
                    context.pushNamed(deviceDetailsRoute.name!,
                        pathParameters: {'identifier': deviceModel.identifier},
                        extra: deviceModel);
                  },
                  child: DeviceCard(deviceModel: deviceModel));
            },
          ),
        ),
      ),
    );
  }
}

class GridOff extends ConsumerWidget {
  const GridOff({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: 12,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                MediaQuery.of(context).size.width > 600 ? 4 : 2, // 2 colunas
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: BorderRadius.circular(16),
              splashColor: Colors.blueAccent,
              onLongPress: () {},
              onTap: () {
                counterTryState(ref).state++;
                if (counterTry(ref) < 3) {
                  notificationService.showOffline(context);
                }
              },
              child: DeviceCardOff(),
            );
          },
        ),
      ),
    );
  }
}

class DeviceCardOff extends ConsumerWidget {
  const DeviceCardOff({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              Icons.wifi_off,
              size: 50,
            )),
      ),
    );
  }
}
