import 'package:flutter/material.dart';
import 'package:moxy/constant/route_name.dart';

List<Menu> menus = const [
  Menu(
    title: 'Overview',
    icon: Icons.analytics_outlined,
    route: overview,
    subRoutes: [],
  ),
  Menu(
    title: 'Customers',
    icon: Icons.group_outlined,
    route: customerPath,
    subRoutes: [],
  ),
  Menu(
    title: 'Orders',
    icon: Icons.local_shipping,
    route: ordersPath,
    subRoutes: [],
  ),
  Menu(
    title: 'Create',
    icon: Icons.add_circle_outline,
    route: '/',
    subRoutes: [
      Menu(
        title: 'Create Order',
        icon: Icons.create_sharp,
        route: createOrderPath,
        subRoutes: [],
      ),
      Menu(
        title: 'Create Product',
        icon: Icons.create,
        route: createProductPath,
        subRoutes: [],
      ),
    ],
  ),
  Menu(
    title: 'Transactions',
    icon: Icons.monetization_on_outlined,
    route: transactionPath,
    subRoutes: [],
  ),
  Menu(
    title: 'Feedbacks',
    icon: Icons.reviews_outlined,
    route: feedbackPath,
    subRoutes: [],
  ),
];

@immutable
class Menu {
  final String title;
  final IconData icon;
  final String route;
  final List<Menu> subRoutes;

  const Menu({
    required this.title,
    required this.icon,
    this.route = overview,
    this.subRoutes = const [],
  });
}
