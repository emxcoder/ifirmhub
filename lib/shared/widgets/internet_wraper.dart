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
  @override
  Widget build(BuildContext context) {
    final status = ref.watch(internetStatusProvider);

    return status.when(
      data: (hasInternet) {
        addPost(hasInternet, ref);
        if (!hasInternet) {
          Future.delayed(Duration(seconds: 2)).then((value) => Text('Hello'));
          return widget.child;
        } else {
          return widget.child;
        }
      },
      error: (error, stackTrace) {
        return NoConnectionPage();
      },
      loading: () {
        return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.asset('assets/icon/icon.png').image)),
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

class NoConnectionPage extends ConsumerWidget {
  const NoConnectionPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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

void addPost(bool hasInternet, WidgetRef ref) {
  !hasInternet
      ? WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          _showBanner(ref);
        })
      : scaffoldMKey.currentState?.clearMaterialBanners();
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
