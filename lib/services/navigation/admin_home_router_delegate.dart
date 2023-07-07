import 'package:flutter/material.dart';
import 'package:moxy/ui/screens/admin/pages/create_order/create_order_page.dart';
import 'package:moxy/ui/screens/admin/pages/create_product/create_product_page.dart';
import 'package:moxy/ui/screens/admin/pages/create_user/create_user_page.dart';
import 'package:moxy/ui/screens/admin/pages/customers/users_page.dart';
import 'package:moxy/ui/screens/admin/pages/edit_order/edit_order_page.dart';
import 'package:moxy/ui/screens/admin/pages/feedbacks/feedbacks_page.dart';
import 'package:moxy/ui/screens/admin/pages/order_product_list/order_product_list.dart';
import 'package:moxy/ui/screens/admin/pages/orders/orders_page.dart';
import 'package:moxy/ui/screens/admin/pages/orders_filter/orders_filter_page.dart';
import 'package:moxy/ui/screens/admin/pages/overview/overview_page.dart';
import 'package:moxy/ui/screens/admin/pages/products/products_page.dart';
import 'package:moxy/ui/screens/admin/pages/transactions/transactions_page.dart';

import 'admin_home_router_cubit.dart';

class AdminHomeRouterDelegate extends RouterDelegate<AdminHomeRouterState> {
  final GlobalKey<NavigatorState> _navigatorKey;
  final AdminHomeRouterCubit _routerCubit;
  AdminHomeRouterDelegate(
      GlobalKey<NavigatorState> navigatorKey, AdminHomeRouterCubit routerCubit)
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
    // ignore: unused_local_variable
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
    if (_routerCubit.state is UsersPageState) {
      extraPageContent =
          (_routerCubit.state as UsersPageState).extraPageContent;
      return [
        _materialPage(
          valueKey: "customers",
          child: const UsersPage(),
        ),
      ];
    }
    if (_routerCubit.state is CreateOrderPageState) {
      // ignore: unused_local_variable
      final state = _routerCubit.state as CreateOrderPageState;
      return [
        _materialPage(
          valueKey: "createOrder",
          child: const CreateOrderPage(),
        ),
      ];
    }
    if (_routerCubit.state is EditOrderPageState) {
      // ignore: unused_local_variable
      final state = _routerCubit.state as EditOrderPageState;
      return [
        _materialPage(
          valueKey: "editOrder",
          child: const EditOrderPage(),
        ),
      ];
    }
    if (_routerCubit.state is FilterOrderPageState) {
      // ignore: unused_local_variable
      final state = _routerCubit.state as FilterOrderPageState;
      return [
        _materialPage(
          valueKey: "filterOrder",
          child: const FilterOrderPage(),
        ),
      ];
    }
    if (_routerCubit.state is OrderProductListPageState) {
      extraPageContent =
          (_routerCubit.state as OrderProductListPageState).extraPageContent;
      return [
        _materialPage(
          valueKey: "createOrder",
          child: const OrderProductList(),
        ),
      ];
    }
    if (_routerCubit.state is CreateUserPageState) {
      extraPageContent =
          (_routerCubit.state as CreateUserPageState).extraPageContent;
      return [
        _materialPage(
          valueKey: "createUser",
          child: const CreateUserPage(),
        ),
      ];
    }
    if (_routerCubit.state is CreateProductPageState) {
      final state = _routerCubit.state as CreateProductPageState;
      bool? isEditMode = state.isEditMode ?? false;
      String? editProductId = state.editProductId;
      return [
        _materialPage(
          valueKey: "createProduct",
          child: CreateProductPage(
              editProductId: editProductId, isEditMode: isEditMode),
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
  Future<void> setNewRoutePath(AdminHomeRouterState configuration) async {}
}
