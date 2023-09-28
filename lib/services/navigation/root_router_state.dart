part of 'root_router_cubit.dart';

abstract class RootRoute extends Equatable {
  static const String loginPath = 'login';
  static const String splashPath = '#';
  static const String adminPath = 'admin';
  static const String shopPath = 'shop';

  const RootRoute();
  @override
  List<Object?> get props => [];
  String urlPath();

  factory RootRoute.fromUri(Uri uri) {
    if (uri.pathSegments.isEmpty) {
      return const LoginRoute();
    } else if (uri.pathSegments.length == 1) {
      String first = uri.pathSegments.first;
      switch (first) {
        case loginPath:
          return const LoginRoute();
        case adminPath:
          return const AdminHomeRoute();
        case shopPath:
          return const ShopRoute();
      }
    }
    return const LoginRoute();
  }
}

class AdminHomeRoute extends RootRoute {
  final String? extraPageContent;
  const AdminHomeRoute([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];

  @override
  String urlPath() => RootRoute.adminPath;
}

class ShopRoute extends RootRoute {
  final String? extraPageContent;
  const ShopRoute([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];

  @override
  String urlPath() => RootRoute.shopPath;
}

class LoginRoute extends RootRoute {
  final String? extraPageContent;
  const LoginRoute([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];

  @override
  String urlPath() => RootRoute.loginPath;
}

class SplashRoute extends RootRoute {
  const SplashRoute();

  @override
  String urlPath() => RootRoute.splashPath;
}
