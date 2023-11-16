import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/config/routes.dart';
import 'package:moxy/ui/screens/admin/admin_root_view.dart';
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

  static loginPath() => '/${Routes.loginPath}';
  static homeNewPath() => '/${Routes.newPath}';
  static homeBagsPath() => '/${Routes.homeBagsPath}';
  static homeAccessoriesPath() => '/${Routes.accessoriesPath}';
  static searchPath() => '/${Routes.searchPath}';
  static favoritesPath() => '/${Routes.favoritesPath}';
  static profileInfoPath() =>
      '/${Routes.profilePath}/${Routes.profileInfoPath}';
  static profileOrdersPath() =>
      '/${Routes.profilePath}/${Routes.profileOrdersPath}';
  static profileAdressesPath() =>
      '/${Routes.profilePath}/${Routes.profileAddressesPath}';
  static checkoutPath() => '/${Routes.checkoutPath}';
  static producDetailsPath(String productId) =>
      '/${Routes.newPath}/${Routes.productDetailsPath}/$productId';

  /// get route name with parameters, here [id] is optional because we need [:id] to define path on [_singleArticleWithParams]
  static singleArticleWithParams([String? id]) => '/article/${id ?? ':id'}';

  static Widget _loginScreen(BuildContext context, GoRouterState state) =>
      const AuthenticationView();
  static Widget _adminScreen(BuildContext context, GoRouterState state) =>
      AdminRootView();
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
        redirect: (context, state) => '/${Routes.splashPath}',
      ),
      GoRoute(path: '/${Routes.splashPath}', builder: _splashScreen),
      GoRoute(path: '/${Routes.loginPath}', builder: _loginScreen),
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
                      path: '${Routes.productDetailsPath}/:productId',
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
                path: '/${Routes.profilePath}/:extraPage',
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
    ],
    errorBuilder: errorWidget,
  );

  static GoRouter get router => _router;
}

const searchIndex = 3;
const favoritesIndex = 4;
const profileIndex = 5;

enum CategoryTab { brandNew, bags, accessories }
