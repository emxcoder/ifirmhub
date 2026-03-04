import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ifirmhub/app/router/routes.dart';
import 'package:ifirmhub/constants/keys.dart';

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
