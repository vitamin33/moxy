import 'package:go_router/go_router.dart';

class NavigationService {
  late GoRouter router;

  void go(String route) {
    router.go(route);
  }

  void push(String route) {
    router.push(route);
  }
}
