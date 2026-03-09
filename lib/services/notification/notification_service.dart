import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class NotificationService {
  void showOffline(BuildContext context) {
    return showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(message: 'No Internet Connection'),
      persistent: false,
      snackBarPosition: SnackBarPosition.top,
    );
  }
}
