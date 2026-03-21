import 'package:flutter/material.dart';
import 'package:ifirmhub/constants/keys.dart';

void showSnack(text) {
  scaffoldMKey.currentState?.showSnackBar(SnackBar(content: Text(text)));
}
