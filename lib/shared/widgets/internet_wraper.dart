import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/keys.dart';
import '../../services/internet/network_provider.dart';

class GlobalInternetListener extends ConsumerStatefulWidget {
  final Widget child;
  const GlobalInternetListener({super.key, required this.child});

  @override
  ConsumerState<GlobalInternetListener> createState() =>
      _GlobalInternetListenerState();
}

class _GlobalInternetListenerState
    extends ConsumerState<GlobalInternetListener> {
  late bool status;
  late Timer time;
  int counter = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final internetCheck = ref.watch(internetStatusProvider);
    bool status = internetCheck.value != null && internetCheck.value == true;

    // if (!status) {
    //   Future.delayed(
    //     Duration(seconds: 10),
    //     () {
    //       setState(() {
    //         counter = 3;
    //       });
    //     },
    //   );
    //   addPost(status, ref);
    // } else {
    //   // addPost(status, ref);
    //   setState(() {
    //     counter = 0;
    //   });
    // }
    return Stack(
      children: [
        addPost(status, ref), //
        widget.child,
        // if (status) Positioned.fill(child: NoConnectionPage()),
      ],
    );
  }
}

class NoConnectionPage extends ConsumerWidget {
  const NoConnectionPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black87.withAlpha(200),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Sem conexão com a internet',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => ref.read(networkServiceProvider).retry(),
              child: Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }
}

Widget addPost(bool hasInternet, WidgetRef ref) {
  !hasInternet
      ? WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          _showBanner(ref);
        })
      : scaffoldMKey.currentState?.clearMaterialBanners();
  return Visibility(child: Text('Connection...'));
}

void _showBanner(WidgetRef ref) {
  scaffoldMKey.currentState?.showMaterialBanner(
    MaterialBanner(
      backgroundColor: Colors.red.shade700,
      content: const Text(
        "No Internet Connection",
        style: TextStyle(color: Colors.white),
      ),
      leading: const Icon(Icons.wifi_off, color: Colors.white),
      actions: [
        TextButton(
          onPressed: () {
            ref.read(networkServiceProvider).retry();
          },
          child: const Text(
            "Retry",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
