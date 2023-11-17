import 'package:flutter/material.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moxy/services/navigation/router_provider.dart';

List<Menu> getLocalizedMenus(BuildContext context) {
  return [
    Menu(
      title: AppLocalizations.of(context)!.overview,
      icon: IconPath.overview,
      routePath: RouterProvider.adminDashboardPath(),
      subRoutes: const [],
    ),
    Menu(
      title: AppLocalizations.of(context)!.customers,
      icon: IconPath.customers,
      routePath: RouterProvider.adminUsersPath(),
      subRoutes: const [],
    ),
    Menu(
      title: AppLocalizations.of(context)!.orders,
      icon: IconPath.orders,
      routePath: RouterProvider.adminOrdersPath(),
      subRoutes: const [],
    ),
    Menu(
      title: AppLocalizations.of(context)!.create,
      icon: IconPath.customers,
      routePath: RouterProvider.adminDashboardPath(),
      subRoutes: [
        Menu(
          title: AppLocalizations.of(context)!.createUser,
          icon: IconPath.createProduct,
          routePath: RouterProvider.adminCreateUserPath(),
          subRoutes: const [],
        ),
        Menu(
          title: AppLocalizations.of(context)!.createOrder,
          icon: IconPath.createProduct,
          routePath: RouterProvider.adminCreateOrderPath(),
          subRoutes: const [],
        ),
        Menu(
          title: AppLocalizations.of(context)!.createProduct,
          icon: IconPath.createProduct,
          routePath: RouterProvider.adminCreateProductPath(),
          subRoutes: const [],
        ),
      ],
    ),
    Menu(
      title: AppLocalizations.of(context)!.products,
      icon: IconPath.product,
      routePath: RouterProvider.adminProductsPath(),
      subRoutes: const [],
    ),
    Menu(
      title: AppLocalizations.of(context)!.feedbacks,
      icon: IconPath.feedbacks,
      routePath: RouterProvider.adminFeedbacksPath(),
      subRoutes: const [],
    ),
  ];
}

class Menu {
  final String title;
  final String icon;
  final String routePath;
  final List<Menu> subRoutes;

  Menu({
    required this.title,
    required this.icon,
    required this.routePath,
    this.subRoutes = const [],
  });
}
