import 'package:flutter/material.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/services/navigation/admin_home_router_cubit.dart';

List<Menu> menus = const [
  Menu(
    title: 'Overview',
    icon: IconPath.overview,
    route: OverviewPageState(),
    subRoutes: [],
  ),
  Menu(
    title: 'Customers',
    icon: IconPath.customers,
    route: UsersPageState(),
    subRoutes: [],
  ),
  Menu(
    title: 'Orders',
    icon: IconPath.orders,
    route: OrdersPageState(),
    subRoutes: [],
  ),
  Menu(
    title: 'Create',
    icon: IconPath.customers,
    route: EmptyState(),
    subRoutes: [
      Menu(
        title: 'Create User',
        icon: IconPath.createProduct,
        route: CreateUserPageState(),
        subRoutes: [],
      ),
      Menu(
        title: 'Create Order',
        icon: IconPath.createProduct,
        route: CreateOrderPageState(),
        subRoutes: [],
      ),
      Menu(
        title: 'Create Product',
        icon: IconPath.createProduct,
        route: CreateProductPageState(isEditMode: false),
        subRoutes: [],
      ),
    ],
  ),
  Menu(
    title: 'Products',
    icon: IconPath.product,
    route: ProductsPageState(),
    subRoutes: [],
  ),
  Menu(
    title: 'Feedbacks',
    icon: IconPath.feedbacks,
    route: FeedbacksPageState(),
    subRoutes: [],
  ),
];

@immutable
class Menu {
  final String title;
  final String icon;
  final AdminHomeRouterState route;
  final List<Menu> subRoutes;

  const Menu({
    required this.title,
    required this.icon,
    this.route = const OverviewPageState(),
    this.subRoutes = const [],
  });
}
