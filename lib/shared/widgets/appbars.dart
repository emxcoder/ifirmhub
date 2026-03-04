import 'package:flutter/material.dart';

const imageUrl = 'https://i.im.ge/2026/03/05/ebkezC.iFirmIcon-1.png';
final topAppBar = AppBar(
  leading: Image.network(
    imageUrl,
  ),
  title: const Text('iFirmHub'),
  centerTitle: true,
);
