import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/config/routes.dart';
import 'package:moxy/ui/screens/admin/admin_root_view.dart';
import 'package:moxy/ui/screens/admin/pages/create_order/create_order_page.dart';
import 'package:moxy/ui/screens/admin/pages/create_product/create_product_page.dart';
import 'package:moxy/ui/screens/admin/pages/create_user/create_user_page.dart';
import 'package:moxy/ui/screens/admin/pages/customers/users_page.dart';
import 'package:moxy/ui/screens/admin/pages/edit_order/edit_order_page.dart';
import 'package:moxy/ui/screens/admin/pages/feedbacks/feedbacks_page.dart';
import 'package:moxy/ui/screens/admin/pages/order_product_list/order_product_list_screen.dart';
import 'package:moxy/ui/screens/admin/pages/orders/orders_page.dart';
import 'package:moxy/ui/screens/admin/pages/overview/overview_page.dart';
import 'package:moxy/ui/screens/admin/pages/products/products_page.dart';
import 'package:moxy/ui/screens/authentication/authentication_view.dart';
import 'package:moxy/ui/screens/client/root_view.dart';
import 'package:moxy/ui/screens/client/web/checkout/checkout_page.dart';
import 'package:moxy/ui/screens/client/web/favourites/favourites_page.dart';
import 'package:moxy/ui/screens/client/web/home/pages/accessories_product_page.dart';
import 'package:moxy/ui/screens/client/web/home/pages/bags_product_page.dart';
import 'package:moxy/ui/screens/client/web/home/pages/new_product_page.dart';
import 'package:moxy/ui/screens/client/web/product_details.dart/product_details.dart';
import 'package:moxy/ui/screens/client/web/profile/profile_page.dart';
import 'package:moxy/ui/screens/not_found_page.dart';
import 'package:moxy/ui/screens/splash/splash_page.dart';

class RouterProvider {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static loginPath() => '/${Routes.login}';

  // Client pathes
  static homeNewPath() => '/${Routes.brandNew}';
  static homeBagsPath() => '/${Routes.homeBags}';
  static homeAccessoriesPath() => '/${Routes.accessories}';
  static searchPath() => '/${Routes.search}';
  static favoritesPath() => '/${Routes.favorites}';
  static profileInfoPath() => '/${Routes.profile}/${Routes.profileInfo}';
  static profileOrdersPath() => '/${Routes.profile}/${Routes.profileOrders}';
  static profileAdressesPath() =>
      '/${Routes.profile}/${Routes.profileAddresses}';
  static checkoutPath() => '/${Routes.checkout}';
  static producDetailsPath(String productId) =>
      '/${Routes.brandNew}/${Routes.productDetails}/$productId';

  // Admin pathes
  static adminProductsPath() => '/${Routes.adminProducts}';
  static adminCreateProductPath([bool isEditMode = false]) =>
      '/${Routes.adminCreateProduct}/$isEditMode';
  static adminEditProductPath(String productId) =>
      '/${Routes.adminProducts}/${Routes.adminEditProduct}/$productId';
  static adminDashboardPath() => '/${Routes.adminDashboard}';
  static adminUsersPath() => '/${Routes.adminUsers}';
  static adminCreateUserPath() =>
      '/${Routes.adminUsers}/${Routes.adminCreateUser}';
  static adminOrdersPath() => '/${Routes.adminOrders}';
  static adminCreateOrderPath() =>
      '/${Routes.adminOrders}/${Routes.adminCreateOrder}';
  static adminEditOrderPath(String orderId) =>
      '/${Routes.adminOrders}/${Routes.adminEditOrder}/$orderId';
  static adminFilterOrderPath() => '/${Routes.adminFilterOrder}';
  static adminOrderProductListPath() => '/${Routes.adminOrderProductList}';
  static adminFeedbacksPath() => '/${Routes.adminFeedbacks}';

  static Widget _loginScreen(BuildContext context, GoRouterState state) =>
      const AuthenticationView();
  static Widget _splashScreen(BuildContext context, GoRouterState state) =>
      const SplashPage();

  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const NotFoundScreen();

  /// use this in [MaterialApp.router]
  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: Routes.root,
        redirect: (context, state) => '/${Routes.splash}',
      ),
      GoRoute(path: '/${Routes.splash}', builder: _splashScreen),
      GoRoute(path: '/${Routes.login}', builder: _loginScreen),

      // CLIENT ROUTES
      StatefulShellRoute(
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          return navigationShell;
        },
        navigatorContainerBuilder: (context, navigationShell, children) {
          return RootView(
            navigationShell: navigationShell,
            children: children,
          );
        },
        branches: [
          StatefulShellBranch(
            initialLocation: homeNewPath(),
            routes: <RouteBase>[
              GoRoute(
                  path: homeNewPath(),
                  builder: (context, state) => const NewProductPage(),
                  routes: [
                    GoRoute(
                      path: '${Routes.productDetails}/:productId',
                      builder: (context, state) => ProductDetailsPage(
                        productId: state.pathParameters['productId'],
                      ),
                    ),
                  ]),
            ],
          ),
          StatefulShellBranch(
            initialLocation: homeBagsPath(),
            routes: <RouteBase>[
              GoRoute(
                path: homeBagsPath(),
                builder: (context, state) => const BagsProductPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            initialLocation: homeAccessoriesPath(),
            routes: <RouteBase>[
              GoRoute(
                path: homeAccessoriesPath(),
                builder: (context, state) => const AccessoriesProductPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            initialLocation: searchPath(),
            routes: <RouteBase>[
              GoRoute(
                path: searchPath(),
                builder: (context, state) => const Text('Search page'),
              ),
            ],
          ),
          StatefulShellBranch(
            initialLocation: favoritesPath(),
            routes: <RouteBase>[
              GoRoute(
                path: favoritesPath(),
                builder: (context, state) => const FavouritesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            initialLocation: profileInfoPath(),
            routes: <RouteBase>[
              GoRoute(
                path: '/${Routes.profile}/:extraPage',
                builder: (context, state) => ProfilePage(
                  extraPage: state.pathParameters['extraPage'],
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            initialLocation: checkoutPath(),
            routes: <RouteBase>[
              GoRoute(
                path: checkoutPath(),
                builder: (context, state) => const CheckoutPage(),
              ),
            ],
          ),
        ],
      ),

      // ADMIN ROUTES
      StatefulShellRoute(
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          return navigationShell;
        },
        navigatorContainerBuilder: (context, navigationShell, children) {
          return AdminRootView(
            navigationShell: navigationShell,
            children: children,
          );
        },
        branches: [
          StatefulShellBranch(
            initialLocation: adminDashboardPath(),
            routes: <RouteBase>[
              GoRoute(
                path: adminDashboardPath(),
                builder: (context, state) => const OverviewPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            initialLocation: adminProductsPath(),
            routes: <RouteBase>[
              GoRoute(
                  path: adminProductsPath(),
                  builder: (context, state) => const ProductsPage(),
                  routes: [
                    GoRoute(
                        path: '${Routes.adminEditProduct}/:productId',
                        builder: (context, state) {
                          return CreateProductPage(
                            editProductId: state.pathParameters['productId'],
                            isEditMode: true,
                          );
                        }),
                  ]),
            ],
          ),
          StatefulShellBranch(
            initialLocation: adminCreateProductPath(),
            routes: <RouteBase>[
              GoRoute(
                  path: '/${Routes.adminCreateProduct}/:isEditMode',
                  builder: (context, state) {
                    return CreateProductPage(isEditMode: false);
                  }),
            ],
          ),
          StatefulShellBranch(
            initialLocation: adminUsersPath(),
            routes: <RouteBase>[
              GoRoute(
                  path: adminUsersPath(),
                  builder: (context, state) => const UsersPage(),
                  routes: [
                    GoRoute(
                      path: Routes.adminCreateUser,
                      builder: (context, state) => const CreateUserPage(),
                    ),
                  ]),
            ],
          ),
          StatefulShellBranch(
            initialLocation: adminOrdersPath(),
            routes: <RouteBase>[
              GoRoute(
                  path: adminOrdersPath(),
                  builder: (context, state) => const OrdersPage(),
                  routes: [
                    GoRoute(
                      path: Routes.adminCreateOrder,
                      builder: (context, state) => const CreateOrderPage(),
                    ),
                    GoRoute(
                      path: '${Routes.adminEditOrder}/:orderId',
                      builder: (context, state) => EditOrderPage(
                        orderId: state.pathParameters['orderId'],
                      ),
                    ),
                  ]),
            ],
          ),
          StatefulShellBranch(
            initialLocation: adminFeedbacksPath(),
            routes: <RouteBase>[
              GoRoute(
                path: adminFeedbacksPath(),
                builder: (context, state) => const FeedbacksPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            initialLocation: adminOrderProductListPath(),
            routes: <RouteBase>[
              GoRoute(
                path: adminOrderProductListPath(),
                builder: (context, state) => const OrderProductListScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: errorWidget,
  );

  static GoRouter get router => _router;
}

const searchIndex = 3;
const favoritesIndex = 4;
const profileIndex = 5;

enum CategoryTab { brandNew, bags, accessories }
