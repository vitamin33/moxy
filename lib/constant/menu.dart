import 'package:flutter/material.dart';
import 'package:moxy/constant/route_name.dart';
import 'package:moxy/navigation/home_router_cubit.dart';

List<Menu> menus = const [
  Menu(
    title: 'Overview',
    icon: Icons.analytics_outlined,
    route: OverviewPageState(),
    subRoutes: [],
  ),
  Menu(
    title: 'Customers',
    icon: Icons.group_outlined,
    route: CustomersPageState(),
    subRoutes: [],
  ),
  Menu(
    title: 'Orders',
    icon: Icons.local_shipping,
    route: OrdersPageState(),
    subRoutes: [],
  ),
  Menu(
    title: 'Create',
    icon: Icons.add_circle_outline,
    route: EmptyState(),
    subRoutes: [
      Menu(
        title: 'Create Order',
        icon: Icons.create_sharp,
        route: CreateOrderPageState(),
        subRoutes: [],
      ),
      Menu(
        title: 'Create Product',
        icon: Icons.create,
        route: CreateProductPageState(isEditMode: false),
        subRoutes: [],
      ),
    ],
  ),
  Menu(
    title: 'Products',
    icon: Icons.shopping_basket_outlined,
    route: ProductsPageState(),
    subRoutes: [],
  ),
  Menu(
    title: 'Feedbacks',
    icon: Icons.reviews_outlined,
    route: FeedbacksPageState(),
    subRoutes: [],
  ),
];

@immutable
class Menu {
  final String title;
  final IconData icon;
  final HomeRouterState route;
  final List<Menu> subRoutes;

  const Menu({
    required this.title,
    required this.icon,
    this.route = const OverviewPageState(),
    this.subRoutes = const [],
  });
}
