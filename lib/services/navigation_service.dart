// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:moxy/screens/authentication/authentication_view.dart';
import 'package:moxy/screens/dashboard/pages/customers/customers_page.dart';
import 'package:moxy/screens/dashboard/pages/feedbacks/feedbacks_page.dart';
import 'package:moxy/screens/dashboard/pages/orders/orders_page.dart';
import 'package:moxy/screens/dashboard/pages/transactions/transactions_page.dart';
import 'package:moxy/utils/common.dart';

import '../constant/route_name.dart';
import '../screens/dashboard/pages/create_category/create_category_page.dart';
import '../screens/dashboard/pages/create_product/create_product_page.dart';
import '../screens/dashboard/pages/products/products_page.dart';
import '../screens/dashboard/pages/overview/overview_page.dart';
import 'get_it.dart';
import "package:universal_html/html.dart" as html;

class NavigationService {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  ValueNotifier<String> routeNotifier = ValueNotifier<String>(authPath);
  ValueNotifier<String> titleNotifier = ValueNotifier<String>('');

  ValueNotifier<bool> showNavigationBar = ValueNotifier<bool>(false);

  List<String> pathToCloseNavigationBar = [
    authPath,
  ];

  set setNavigationBar(bool value) {
    showNavigationBar.value = value;
    showNavigationBar.notifyListeners();
  }

  void toggleNavigationBar() {
    showNavigationBar.value = !showNavigationBar.value;
    showNavigationBar.notifyListeners();
  }

  String determineHomePath(bool hasUser) {
    if (hasUser) {
      return overview;
    }
    return authPath;
  }

  Route? onGeneratedRoute(RouteSettings settings) {
    html.window.history.pushState(null, 'moxy', "#${settings.name}");

    switch (settings.name) {
      case authPath:
        return navigateToPageRoute(settings, const AuthenticationView());
      case overview:
      case root:
        return navigateToPageRoute(settings, OverviewPage());
      case customerPath:
        return navigateToPageRoute(settings, const CustomersPage());
      case ordersPath:
        return navigateToPageRoute(settings, const OrdersPage());
      case productsPath:
        return navigateToPageRoute(settings, const ProductsPage());
      case feedbackPath:
        return navigateToPageRoute(settings, const FeedbacksPage());
      case transactionPath:
        return navigateToPageRoute(settings, const TransactionsPage());

      case createOrderPath:
        return navigateToPageRoute(settings, const CreateOrderPage());
      case createProductPath:
        return navigateToPageRoute(settings, const CreateProductView());
    }
    return null;
  }

  PageRoute navigateToPageRoute(RouteSettings settings, Widget page,
      {bool maintainState = true, bool fullscreenDialog = false}) {
    return PageRouteBuilder(
      pageBuilder: (c, a1, a2) => page,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      settings: settings,
      transitionsBuilder: (c, anim, a2, child) =>
          FadeTransition(opacity: anim, child: child),
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  String _mapPathToTitle(String path) {
    moxyPrint('Path: $path');
    switch (path) {
      case overview:
        return 'Dashboard';
      case authPath:
        return 'Login';
      case productsPath:
        return 'Products';
      case customerPath:
        return 'Customers';
      case ordersPath:
        return 'Orders';
      case createPath:
        return 'Create';
      case transactionPath:
        return 'Transactions';
      case feedbackPath:
        return 'Reviews';
      case createProductPath:
        return 'Create product';
      case createOrderPath:
        return 'Create order';
    }
    return '';
  }

  void navigatePushReplaceName(String path) {
    moxyPrint('Path: $path');
    titleNotifier.value = _mapPathToTitle(path);
    navigatorKey.currentState!
        .pushNamedAndRemoveUntil(path, (route) => route.isFirst);
  }
}

class RouteObservers extends RouteObserver<PageRoute<dynamic>> {
  final navigationService = locate<NavigationService>();

  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    if (previousRoute is PageRoute && route is PageRoute) {
      final settings = previousRoute.settings;
      if (settings.name != '/') {
        final routeList = settings.name?.split("?").toList();
        String routePath = routeList?[0] ?? authPath;
        navigationService.routeNotifier.value = routePath;

        final containPreviousRoutePath = navigationService
            .pathToCloseNavigationBar
            .contains(previousRoute.settings.name);

        if (containPreviousRoutePath) {
          navigationService.setNavigationBar = false;
        }

        if (!containPreviousRoutePath) {
          navigationService.setNavigationBar = true;
        }
      }
    }
    super.didPop(route!, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (previousRoute is PageRoute && route is PageRoute) {
      final settings = route.settings;

      if (settings.name != '/') {
        final routeList = settings.name?.split("?").toList();
        String routePath = routeList?[0] ?? authPath;
        navigationService.routeNotifier.value = routePath;

        final paths = navigationService.pathToCloseNavigationBar;
        final containRoutePath = paths.contains(route.settings.name);

        if (containRoutePath) {
          navigationService.setNavigationBar = false;
        } else {
          navigationService.setNavigationBar = true;
        }
      }
    }
    super.didPush(route, previousRoute);
  }
}

void navigatePushReplaceName(String path) {
  locate<NavigationService>().navigatePushReplaceName(path);
}
