import 'package:flutter/material.dart';
import 'package:moxy/ui/screens/authentication/authentication_view.dart';
import 'package:moxy/ui/screens/admin/admin_root_view_mobile.dart';

import 'root_router_cubit.dart';

class RootRouterDelegate extends RouterDelegate<RootRouterState> {
  final GlobalKey<NavigatorState> _navigatorKey;
  final RootRouterCubit _routerCubit;
  RootRouterDelegate(
      GlobalKey<NavigatorState> navigatorKey, RootRouterCubit routerCubit)
      : _navigatorKey = navigatorKey,
        _routerCubit = routerCubit;
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  @override
  Widget build(BuildContext context) => Navigator(
        key: navigatorKey,
        pages: List.from([
          _materialPage(valueKey: "auth", child: const AuthenticationView()),
          ..._extraPages,
        ]),
        onPopPage: _onPopPageParser,
      );
  bool _onPopPageParser(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result)) return false;
    popRoute();
    return true;
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
    if (_routerCubit.state is AdminPageState) {
      extraPageContent =
          (_routerCubit.state as AdminPageState).extraPageContent;
      return [
        _materialPage(
          valueKey: "main",
          child: AdminRootViewMobile(),
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
  Future<void> setNewRoutePath(RootRouterState configuration) async {}
}
