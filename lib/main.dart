import 'package:algorithm_with_flutter_ui/path_findding/screen/path_findding_screen.dart';
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
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PathFinddingScreen()
      ),
    );
  }
}
