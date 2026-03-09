import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ifirmhub/core/utils/utils.dart';
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
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (hasInternetGlobal(ref)) {
          counterTryState(ref).state = 0;
        }
      },
    );
    return Stack(
      children: [
        widget.child,
        if (!hasInternetGlobal(ref) && counterTry(ref) == 3)
          Positioned.fill(child: NoConnectionPage()),
      ],
    );
  }
}

class NoConnectionPage extends ConsumerWidget {
  const NoConnectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(internetStatusProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87.withAlpha(200),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (status.isLoading)
                Center(
                  child: SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator()),
                ),
              Icon(Icons.wifi_off, size: 100, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'Sem conexão com a internet',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  return ref.refresh(internetStatusProvider.future);
                },
                child: Text('Tentar novamente'),
              ),
              ElevatedButton.icon(
                  onPressed: () => ref.refresh(internetStatusProvider.future),
                  label: Text('Open Settings'),
                  icon: Icon(Icons.settings)),
            ],
          ),
        ),
      ),
    );
  }
}
