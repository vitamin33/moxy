import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moxy/ui/screens/authentication/authentication_view.dart';
import 'package:moxy/ui/screens/splash/splash_page.dart';
import 'package:moxy/utils/common.dart';

import 'root_router_cubit.dart';

class RootRouterDelegate extends RouterDelegate<RootRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RootRoute> {
  final GlobalKey<NavigatorState> _navigatorKey;
  final RootRouterCubit _routerCubit;
  RootRouterDelegate(
      GlobalKey<NavigatorState> navigatorKey, RootRouterCubit routerCubit)
      : _navigatorKey = navigatorKey,
        _routerCubit = routerCubit;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  RootRoute? get currentConfiguration => _routerCubit.state;

  @override
  Widget build(BuildContext context) => Navigator(
        key: navigatorKey,
        pages: List.from([
          if (_routerCubit.state is SplashRoute)
            _materialPage(valueKey: "splash", child: const SplashPage()),
          ..._extraPages,
        ]),
        onPopPage: _onPopPageParser,
      );
  bool _onPopPageParser(Route<dynamic> route, dynamic result) {
    return false;
  }

  @override
  Future<bool> popRoute() async {
    if (_extraPages.isNotEmpty) {
      _routerCubit.popExtra();
      return true;
    }

    return await _confirmAppExit();
  }

  List<Page> get _extraPages {
    // ignore: unused_local_variable
    String? extraPageContent;
    if (_routerCubit.state is LoginRoute) {
      extraPageContent = (_routerCubit.state as LoginRoute).extraPageContent;
      return [
        _materialPage(
          valueKey: "login",
          child: const AuthenticationView(),
        ),
      ];
    }
    if (_routerCubit.state is AdminHomeRoute) {
      extraPageContent =
          (_routerCubit.state as AdminHomeRoute).extraPageContent;
      return [
        _materialPage(
          valueKey: "admin_main",
          child: Container(),
        ),
      ];
    }
    if (_routerCubit.state is ShopRoute) {
      extraPageContent = (_routerCubit.state as ShopRoute).extraPageContent;
      return [
        _materialPage(
          valueKey: "client_main",
          //child: const RootView(),
          child: Container(),
        ),
      ];
    }
    return [];
  }

  Future<bool> _confirmAppExit() async =>
      await showDialog<bool>(
          context: navigatorKey.currentContext!,
          builder: (context) {
            return AlertDialog(
              title: const Text("Root Exit App"),
              content: const Text("Are you sure you want to exit the app?"),
              actions: [
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.pop(context, true),
                ),
                TextButton(
                  child: const Text("Confirm"),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            );
          }) ??
      true;
  Page _materialPage({
    required String valueKey,
    required Widget child,
  }) =>
      MaterialPage(
        key: ValueKey<String>(valueKey),
        child: child,
      );
//It's not needed for bloc/cubit
  @override
  void addListener(VoidCallback listener) {}
//It's not needed for bloc/cubit
  @override
  void removeListener(VoidCallback listener) {}
//It's not needed for now
  @override
  Future<void> setNewRoutePath(RootRoute configuration) async {
    switch (configuration.runtimeType) {
      case AdminHomeRoute:
        _routerCubit.goToAdminFlow();
        break;
      case ShopRoute:
        _routerCubit.goToClientHomeFlow();
        break;
      case LoginRoute:
        _routerCubit.goToAuthFlow();
        break;
    }

    moxyPrint('root_router_delegate, setNewRoutePath() called, $configuration');
    return SynchronousFuture<void>(null);
  }
}
