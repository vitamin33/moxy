import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/ui/screens/not_found_page.dart';

class Routes {
  // root routes
  static const root = '/';
  static const homeNamedPage = 'home';
  static const loginPath = 'login';
  static const splashPath = 'splash';
  static const adminPath = 'admin';
  static const shopPath = 'shop';

  // client routes
  static const homePath = 'home';
  static const newPath = 'new';
  static const homeBagsPath = 'bags';
  static const accessoriesPath = 'accessories';
  static const searchPath = 'search';
  static const favoritesPath = 'favorites';
  static const checkoutPath = 'checkout';
  static const productDetailsPath = 'product';
  static const ordersPath = 'orders';
  static const addressesPath = 'address';
  // profile
  static const profilePath = 'profile';
  static const profileInfoPath = 'info';
  static const profileOrdersPath = 'orders';
  static const profileAddressesPath = 'address';

  // admin routes
  static const productsPath = 'products';
  static const createProductPath = 'create-product';
  static const dashboardPath = 'dashboard';
  static const usersPath = 'users';
  static const createUserPath = 'create-user';
  static const adminOrdersPath = 'orders';
  static const editOrderPath = 'edit-order';
  static const filterOrderPath = 'filter-order';
  static const orderProductListPath = 'order-product-list';
  static const feedbacksPath = 'feedbacks';

  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const NotFoundScreen();
}
