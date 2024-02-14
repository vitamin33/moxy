import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/ui/screens/not_found_page.dart';

class Routes {
  // root routes
  static const root = '/';
  static const homeNamedPage = 'home';
  static const login = 'login';
  static const register = 'register';
  static const resetPassword = 'reset-password';
  static const newPassword = 'new-password';
  static const successPassword = 'success-password';
  static const splash = 'splash';
  static const admin = 'admin';
  static const shop = 'shop';

  // client routes
  static const home = 'home';
  static const brandNew = 'new';
  static const homeBags = 'bags';
  static const accessories = 'accessories';
  static const search = 'search';
  static const favorites = 'favorites';
  static const checkout = 'checkout';
  static const productDetails = 'product';
  static const orders = 'orders';
  static const addresses = 'address';
  // profile
  static const profile = 'profile';
  static const profileInfo = 'info';
  static const profileOrders = 'orders';
  static const profileAddresses = 'address';

  // admin routes
  static const adminProducts = 'products';
  static const adminCreateProduct = 'create-product';
  static const adminEditProduct = 'edit-product';
  static const adminDashboard = 'dashboard';
  static const adminUsers = 'users';
  static const adminCreateUser = 'create-user';
  static const adminOrders = 'orders';
  static const adminCreateOrder = 'create-order';
  static const adminEditOrder = 'edit-order';
  static const adminFilterOrder = 'filter-order';
  static const adminOrderProductList = 'order-product-list';
  static const adminFeedbacks = 'feedbacks';
  static const adminNovaPostENs = 'nova-post-ens';

  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const NotFoundScreen();
}
