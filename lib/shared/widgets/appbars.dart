import 'package:flutter/material.dart';
import 'package:ifirmhub/constants/constants.dart';

const imageUrlAppBar = 'https://i.im.ge/2026/03/05/ebkezC.iFirmIcon-1.png';
final topAppBar = AppBar(
  title: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: iconImage,
      ),
      const Text('iFirmHub'),
    ],
  ),
  centerTitle: true,
);
