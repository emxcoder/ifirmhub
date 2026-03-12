import 'package:go_router/go_router.dart';
import 'package:ifirmhub/core/models/device_model.dart';
import 'package:ifirmhub/core/models/products_model.dart';
import 'package:ifirmhub/pages/firmware_page/firmware_page.dart';
import 'package:ifirmhub/pages/home_page/home_page.dart';

import '../../pages/detail_page/device_detail_page.dart';
import '../../pages/device_page/device_page.dart';

final homeRoute = GoRoute(
    path: '/',
    name: 'home_page',
    builder: (context, state) => HomePage(),
    routes: [deviceRoute, deviceDetailsRoute, firmwarePageRoute]);

final deviceRoute = GoRoute(
  path: '/device/:type',
  name: 'device_page',
  builder: (context, state) {
    final type = state.pathParameters['type'] as String;
    final typeExtra = state.extra as ProductModel?;
    return DevicePage(
      typePath: type,
      productModelLocal: typeExtra,
    );
  },
);

final deviceDetailsRoute = GoRoute(
  path: '/device_detail/:identifier',
  name: 'device_detail_page',
  builder: (context, state) {
    final identifier = state.pathParameters['identifier'] as String;
    final deviceModelLocal = state.extra as DeviceModel?;
    return DeviceDetailsPage(
      identifierRoute: identifier,
      deviceModelLocal: deviceModelLocal,
    );
  },
);

final firmwarePageRoute = GoRoute(
  path: '/firmwares/:identifier',
  name: 'firmware_page',
  builder: (context, state) {
    final identifier = state.pathParameters['identifier'] as String;
    final deviceModelLocal = state.extra as DeviceModel?;
    return FirmwarePage(
      identifierRoute: identifier,
      deviceModelLocal: deviceModelLocal,
    );
  },
);
