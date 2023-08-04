import 'package:flutter/material.dart';
import 'package:moxy/ui/screens/client/web/favourites/favourites_page.dart';
import 'package:moxy/ui/screens/client/web/home/home_page.dart';
import 'package:moxy/utils/common.dart';

import '../../../ui/screens/client/web/basket/basket_page.dart';
import '../../../ui/screens/client/web/profile/profile_page.dart';
import 'web_home_router_cubit.dart';

class ClientHomeRouterDelegate extends RouterDelegate<ClientHomeRouterState> {
  final GlobalKey<NavigatorState> _navigatorKey;
  final ClientHomeRouterCubit _routerCubit;
  ClientHomeRouterDelegate(
      GlobalKey<NavigatorState> navigatorKey, ClientHomeRouterCubit routerCubit)
      : _navigatorKey = navigatorKey,
        _routerCubit = routerCubit;
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  @override
  Widget build(BuildContext context) => Navigator(
        key: navigatorKey,
        pages: List.from([
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
    if (_routerCubit.state is! FavouritesRouteState) {
      _routerCubit.goToFavourites();
      return true;
    }
    return await _confirmAppExit();
  }

  List<Page> get _extraPages {
    // ignore: unused_local_variable
    String? extraPageContent;
    if (_routerCubit.state is HomeRouteState) {
      extraPageContent =
          (_routerCubit.state as HomeRouteState).extraPageContent;
      return [
        _materialPage(
          valueKey: "home",
          child: HomePage(),
        ),
      ];
    }
    if (_routerCubit.state is FavouritesRouteState) {
      extraPageContent =
          (_routerCubit.state as FavouritesRouteState).extraPageContent;
      return [
        _materialPage(
          valueKey: "favourites",
          child: const FavouritesPage(),
        ),
      ];
    }
    if (_routerCubit.state is BasketRouteState) {
      extraPageContent =
          (_routerCubit.state as BasketRouteState).extraPageContent;
      return [
        _materialPage(
          valueKey: "basket",
          child: const BasketPage(),
        ),
      ];
    }
    if (_routerCubit.state is ProfilePageState) {
      extraPageContent =
          (_routerCubit.state as ProfilePageState).extraPageContent;
      return [
        _materialPage(
          valueKey: "profile",
          child: const ProfilePage(),
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
              title: const Text("Exit App"),
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
  Future<void> setNewRoutePath(ClientHomeRouterState configuration) async {
    moxyPrint('setNewRoutePath() method called: $configuration');
  }
}
