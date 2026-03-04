import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/router/router.dart';
import 'constants/constants.dart';
import 'constants/keys.dart';
import 'shared/widgets/internet_wraper.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routerConfig,
      title: title,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return GlobalInternetListener(
            child: child ??
                SizedBox(
                  child: Text('Erro'),
                ));
      },
      scaffoldMessengerKey: scaffoldMKey,
    );
  }
}
