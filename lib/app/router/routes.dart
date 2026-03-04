import 'package:go_router/go_router.dart';
import 'package:ifirmhub/core/models/products_model.dart';
import 'package:ifirmhub/pages/home_page/home_page.dart';

import '../../pages/device_page/device_page.dart';

final homeRoute = GoRoute(
    path: '/',
    name: 'home_page',
    builder: (context, state) => HomePage(),
    routes: [deviceRoute]);

final deviceRoute = GoRoute(
  path: '/device/:type',
  name: 'device_page',
  builder: (context, state) {
    final type = state.pathParameters['type'] as String;
    final typeExtra = state.extra as ProductModel?;
    return DevicePage(
      type: type,
      productModel: typeExtra,
    );
  },
);
