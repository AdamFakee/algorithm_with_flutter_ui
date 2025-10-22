import 'package:algorithm_with_flutter_ui/utils/routers/app_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        // -- router
        routerConfig: AppRouters.routers,

        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
