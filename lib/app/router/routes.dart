import 'package:go_router/go_router.dart';
import 'package:ifirmhub/pages/home_page/home_page.dart';

final homeRoute = GoRoute(
  path: '/',
  builder: (context, state) => HomePage(),
);
