import 'package:flutter/material.dart';

const imageUrlAppBar = 'https://i.im.ge/2026/03/05/ebkezC.iFirmIcon-1.png';
final topAppBar = AppBar(
  title: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.network(
          width: 40,
          height: 40,
          imageUrlAppBar,
        ),
      ),
      const Text('iFirmHub'),
    ],
  ),
  centerTitle: true,
);
