import 'package:flutter/material.dart';
import 'package:moxy/ui/screens/client/web/checkout/checkout_page.dart';
import 'package:moxy/ui/screens/client/web/favourites/favourites_page.dart';
import 'package:moxy/ui/screens/client/web/home/home_page.dart';
import 'package:moxy/ui/screens/client/web/product_details.dart/product_details.dart';
import 'package:moxy/utils/common.dart';

import '../../../ui/screens/client/web/profile/profile_page.dart';
import 'client_home_router_cubit.dart';

class ClientHomeRouterDelegate extends RouterDelegate<ClientHomeRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<ClientHomeRoute> {
  final GlobalKey<NavigatorState> _navigatorKey;
  final ClientHomeRouterCubit _routerCubit;
  final TabController _tabController;
  ClientHomeRouterDelegate(GlobalKey<NavigatorState> navigatorKey,
      ClientHomeRouterCubit routerCubit, TabController tabController)
      : _navigatorKey = navigatorKey,
        _routerCubit = routerCubit,
        _tabController = tabController;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  @override
  ClientHomeRoute? get currentConfiguration => _routerCubit.state;

  @override
  Widget build(BuildContext context) => Navigator(
        key: navigatorKey,
        pages: List.from([
          ..._extraPages,
        ]),
        onPopPage: _onPopPageParser,
      );
  bool _onPopPageParser(Route<dynamic> route, dynamic result) {
    return false;
  }

  List<Page> get _extraPages {
    // ignore: unused_local_variable
    String? extraPageContent;
    if (_routerCubit.state is HomeRoute) {
      int tabIndex = (_routerCubit.state as HomeRoute).tabIndex ?? 0;
      return [
        _materialPage(
          valueKey: "home",
          child: HomePage(_tabController, tabIndex),
        ),
      ];
    }
    if (_routerCubit.state is FavouritesRoute) {
      extraPageContent =
          (_routerCubit.state as FavouritesRoute).extraPageContent;
      return [
        _materialPage(
          valueKey: "favourites",
          child: const FavouritesPage(),
        ),
      ];
    }
    if (_routerCubit.state is CheckoutRoute) {
      extraPageContent = (_routerCubit.state as CheckoutRoute).extraPageContent;
      return [
        _materialPage(
          valueKey: "checkout",
          child: const CheckoutPage(),
        ),
      ];
    }
    if (_routerCubit.state is ProfileRoute) {
      final extraPagePath = (_routerCubit.state as ProfileRoute).extraPagePath;
      return [
        _materialPage(
          valueKey: "profile",
          child: ProfilePage(extraPagePath: extraPagePath),
        ),
      ];
    }
    if (_routerCubit.state is ProductDetailsRoute) {
      final productId = (_routerCubit.state as ProductDetailsRoute).productId;
      return [
        _materialPage(
          valueKey: "productDetails",
          child: ProductDetailsPage(productId: productId),

        ),
      ];
    }
    return [];
  }

  Page _materialPage({
    required String valueKey,
    required Widget child,
  }) {
    return MaterialPage(
      key: ValueKey<String>(valueKey),
      child: Material(child: child),
    );
  }

//It's not needed for bloc/cubit
  @override
  void addListener(VoidCallback listener) {}
//It's not needed for bloc/cubit
  @override
  void removeListener(VoidCallback listener) {}
//It's not needed for now
  @override
  Future<void> setNewRoutePath(ClientHomeRoute configuration) async {
    switch (configuration.runtimeType) {
      case FavouritesRoute:
        _routerCubit.goToFavourites();
        break;
      case ProfileRoute:
        ProfileRoute route = configuration as ProfileRoute;
        _routerCubit.goToProfile(route.extraPagePath);
        break;
      case CheckoutRoute:
        _routerCubit.goToCheckout();
        break;
      case ProductDetailsRoute:
        ProductDetailsRoute route = configuration as ProductDetailsRoute;
        _routerCubit.goToProductDetails(route.productId);
        break;
      case HomeRoute:
        int index = configuration.props[0] as int;
        _routerCubit.goToHome(index);
        break;
    }

    moxyPrint(
        'client_home_router_delegate, setNewRoutePath() method called: $configuration');
  }

  @override
  Future<bool> popRoute() {
    return Future.value(false);
  }
}
