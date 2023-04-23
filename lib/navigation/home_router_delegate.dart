import 'package:flutter/material.dart';
import 'package:moxy/screens/dashboard/pages/create_category/create_category_page.dart';
import 'package:moxy/screens/dashboard/pages/create_product/create_product_page.dart';
import 'package:moxy/screens/dashboard/pages/customers/customers_page.dart';
import 'package:moxy/screens/dashboard/pages/feedbacks/feedbacks_page.dart';
import 'package:moxy/screens/dashboard/pages/orders/orders_page.dart';
import 'package:moxy/screens/dashboard/pages/overview/overview_page.dart';
import 'package:moxy/screens/dashboard/pages/products/products_page.dart';
import 'package:moxy/screens/dashboard/pages/transactions/transactions_page.dart';

import 'home_router_cubit.dart';

class HomeRouterDelegate extends RouterDelegate<HomeRouterState> {
  final GlobalKey<NavigatorState> _navigatorKey;
  final HomeRouterCubit _routerCubit;
  HomeRouterDelegate(
      GlobalKey<NavigatorState> navigatorKey, HomeRouterCubit routerCubit)
      : _navigatorKey = navigatorKey,
        _routerCubit = routerCubit;
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  @override
  Widget build(BuildContext context) => Navigator(
        key: navigatorKey,
        pages: List.from([
          //_materialPage(valueKey: "overview", child: OverviewPage()),
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
    if (_routerCubit.state is! ProductsPageState) {
      _routerCubit.goToProducts();
      return true;
    }
    return await _confirmAppExit();
  }

  List<Page> get _extraPages {
    String? extraPageContent;
    if (_routerCubit.state is OverviewPageState) {
      extraPageContent =
          (_routerCubit.state as OverviewPageState).extraPageContent;
      return [
        _materialPage(
          valueKey: "overview",
          child: OverviewPage(),
        ),
      ];
    }
    if (_routerCubit.state is ProductsPageState) {
      extraPageContent =
          (_routerCubit.state as ProductsPageState).extraPageContent;
      return [
        _materialPage(
          valueKey: "products",
          child: const ProductsPage(),
        ),
      ];
    }

    if (_routerCubit.state is FeedbacksPageState) {
      extraPageContent =
          (_routerCubit.state as FeedbacksPageState).extraPageContent;
      return [
        _materialPage(
          valueKey: "feedbacks",
          child: const FeedbacksPage(),
        ),
      ];
    }
    if (_routerCubit.state is TransactionsPageState) {
      extraPageContent =
          (_routerCubit.state as TransactionsPageState).extraPageContent;
      return [
        _materialPage(
          valueKey: "transactions",
          child: const TransactionsPage(),
        ),
      ];
    }
    if (_routerCubit.state is OrdersPageState) {
      extraPageContent =
          (_routerCubit.state as OrdersPageState).extraPageContent;
      return [
        _materialPage(
          valueKey: "orders",
          child: const OrdersPage(),
        ),
      ];
    }
    if (_routerCubit.state is CustomersPageState) {
      extraPageContent =
          (_routerCubit.state as CustomersPageState).extraPageContent;
      return [
        _materialPage(
          valueKey: "customers",
          child: const CustomersPage(),
        ),
      ];
    }
    if (_routerCubit.state is CreateOrderPageState) {
      extraPageContent =
          (_routerCubit.state as CreateOrderPageState).extraPageContent;
      return [
        _materialPage(
          valueKey: "createOrder",
          child: const CreateOrderPage(),
        ),
      ];
    }
    if (_routerCubit.state is CreateProductPageState) {
      extraPageContent =
          (_routerCubit.state as CreateProductPageState).extraPageContent;
      return [
        _materialPage(
          valueKey: "createProduct",
          child: const CreateProductPage(),
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
  Future<void> setNewRoutePath(HomeRouterState configuration) async {}
}
