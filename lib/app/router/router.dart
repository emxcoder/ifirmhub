import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../constants/keys.dart';
import 'routes.dart';

final routerConfig = GoRouter(
  routes: [homeRoute],
  navigatorKey: navigatorKey,
  errorBuilder: (context, state) {
    return Scaffold(
      body: Center(
        child: Text('Page not Found'),
      ),
    );
  },
);
