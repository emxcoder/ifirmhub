import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ifirmhub/shared/widgets/appbars.dart';

import '../../constants/keys.dart';
import '../../services/internet/network_provider.dart';
import 'texts.dart';

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
        return Stack(
          children: [
            widget.child,
            if (!hasInternet) Positioned.fill(child: NoConnectionPage())
          ],
        );
      },
      error: (error, stackTrace) {
        return NoConnectionPage();
      },
      loading: () {
        return Scaffold(
          appBar: topAppBar,
          body: Stack(
            children: [
              Column(
                children: [
                  choosePText,
                  LinearProgressIndicator(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: GridView.builder(
                        itemCount: 10,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 600
                                  ? 4
                                  : 2, // 2 colunas
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 4,
                        ),
                        itemBuilder: (context, index) {
                          return Card();
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {}, child: Text('Tools and Guide')),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
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
