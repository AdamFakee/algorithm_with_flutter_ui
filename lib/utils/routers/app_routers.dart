import 'package:algorithm_with_flutter_ui/features/home/home_screen.dart';
import 'package:algorithm_with_flutter_ui/features/path_findding/screen/path_findding_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouters {
  static final routers = GoRouter(
    initialLocation: '/home',
    routes: [
      // home
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      // path findding
      GoRoute(
        path: '/pathFindding',
        builder: (context, state) => const PathFinddingScreen(),
      )
    ]
  );
}