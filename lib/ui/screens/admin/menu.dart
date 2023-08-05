import 'package:flutter/material.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/services/navigation/admin/admin_home_router_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<Menu> getLocalizedMenus(BuildContext context) {
  return [
    Menu(
      title: AppLocalizations.of(context)!.overview,
      icon: IconPath.overview,
      route: const OverviewPageState(),
      subRoutes: const [],
    ),
    Menu(
      title: AppLocalizations.of(context)!.customers,
      icon: IconPath.customers,
      route: const UsersPageState(),
      subRoutes: const [],
    ),
    Menu(
      title: AppLocalizations.of(context)!.orders,
      icon: IconPath.orders,
      route: const OrdersPageState(),
      subRoutes: const [],
    ),
    Menu(
      title: AppLocalizations.of(context)!.create,
      icon: IconPath.customers,
      route: const EmptyState(),
      subRoutes: [
        Menu(
          title: AppLocalizations.of(context)!.createUser,
          icon: IconPath.createProduct,
          route: const CreateUserPageState(),
          subRoutes: const [],
        ),
        Menu(
          title: AppLocalizations.of(context)!.createOrder,
          icon: IconPath.createProduct,
          route: const CreateOrderPageState(),
          subRoutes: const [],
        ),
        Menu(
          title: AppLocalizations.of(context)!.createProduct,
          icon: IconPath.createProduct,
          route: const CreateProductPageState(isEditMode: false),
          subRoutes: const [],
        ),
      ],
    ),
    Menu(
      title: AppLocalizations.of(context)!.products,
      icon: IconPath.product,
      route: const ProductsPageState(),
      subRoutes: const [],
    ),
    Menu(
      title: AppLocalizations.of(context)!.feedbacks,
      icon: IconPath.feedbacks,
      route: const FeedbacksPageState(),
      subRoutes: const [],
    ),
  ];
}

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
