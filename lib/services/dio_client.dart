import 'package:dio/dio.dart';

final dioBase = Dio(
  BaseOptions(
    baseUrl: 'https://api.ipsw.me/v4',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ),
);
