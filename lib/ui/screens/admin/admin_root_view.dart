import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router/src/route.dart';
import 'package:moxy/config/routes.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/admin/dashboard/dashboard_cubit.dart';
import 'package:moxy/domain/admin/filter_orders/filter_orders_cubit.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/animated_branch_container.dart';
import 'package:moxy/utils/common.dart';
import '../../components/app_scaffold.dart';
import '../components/action_button.dart';
import '../components/flutter_expandable_fab.dart';
import '../components/navigation_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class AdminRootView extends StatelessWidget {
  StatefulNavigationShell navigationShell;
  List<Widget> children;
  AdminRootView(
      {super.key, required this.navigationShell, required this.children});

  @override
  Widget build(BuildContext context) {
    return mobileWidget(context);
  }

  Widget mobileWidget(BuildContext context) {
    final arrIcons = _mapStateToActionIcon(context);

    return AppScaffold(
      appbar: AppBar(
        elevation: 0,
        actions: [
          arrIcons.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: LayoutBuilder(
                    builder: (BuildContext ctx, BoxConstraints constraints) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (final item in arrIcons) ...[
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: SizedBox(
                                width: 60,
                                height: 38,
                                child: InkWell(
                                  onTap: () {
                                    item.onPress(ctx);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: item.text != null
                                        ? Text(
                                            item.text!,
                                            textAlign: TextAlign.center,
                                            textDirection: TextDirection.rtl,
                                            style: const TextStyle(
                                              color: AppTheme.pinkDark,
                                              fontSize: 14,
                                            ),
                                          )
                                        : SvgPicture.asset(item.icon),
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ],
                      );
                    },
                  ),
                )
              : Container()
        ],
        backgroundColor: AppTheme.pink,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            _mapStateToTitleText(context),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            String currentRoute = GoRouter.of(context)
                .routeInformationProvider
                .value
                .uri
                .toString();
            bool showBackButton =
                currentRoute == RouterProvider.adminOrderProductListPath() ||
                    currentRoute == RouterProvider.adminFilterOrderPath() ||
                    isEditOrderRoute(currentRoute);
            if (showBackButton) {
              return IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: SvgPicture.asset(IconPath.backArrow));
            } else {
              return IconButton(
                icon: SvgPicture.asset(IconPath.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: 'Open side bar',
              );
            }
          },
        ),
      ),
      drawer: const DashboardDrawer(),
      floatingActionButton: _buildFabWidget(context),
      body: AnimatedBranchContainer(
        currentIndex: navigationShell.currentIndex,
        children: children,
      ),
    );
  }

  String _mapStateToTitleText(BuildContext context) {
    String currentRoute =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();
    if (currentRoute == RouterProvider.adminDashboardPath()) {
      return AppLocalizations.of(context)!.overview;
    } else if (currentRoute == RouterProvider.adminProductsPath()) {
      return AppLocalizations.of(context)!.products;
    } else if (currentRoute == RouterProvider.adminUsersPath()) {
      return AppLocalizations.of(context)!.customers;
    } else if (currentRoute == RouterProvider.adminOrdersPath()) {
      return AppLocalizations.of(context)!.orders;
    } else if (currentRoute
        .startsWith('/${Routes.adminProducts}/${Routes.adminEditProduct}/')) {
      return AppLocalizations.of(context)!.editProduct;
    } else if (currentRoute == RouterProvider.adminCreateProductPath()) {
      return AppLocalizations.of(context)!.createProduct;
    } else if (currentRoute == RouterProvider.adminCreateOrderPath()) {
      return AppLocalizations.of(context)!.createOrder;
    } else if (isEditOrderRoute(currentRoute)) {
      return AppLocalizations.of(context)!.editOrder;
    } else if (currentRoute == RouterProvider.adminFilterOrderPath()) {
      return AppLocalizations.of(context)!.filter;
    } else if (currentRoute == RouterProvider.adminOrderProductListPath()) {
      return AppLocalizations.of(context)!.orderProductList;
    } else if (currentRoute == RouterProvider.adminCreateUserPath()) {
      return AppLocalizations.of(context)!.createUser;
    } else if (currentRoute == RouterProvider.adminFeedbacksPath()) {
      return AppLocalizations.of(context)!.feedbacks;
    }
    return AppLocalizations.of(context)!.overview;
  }

  List<AppBarIcon> _mapStateToActionIcon(BuildContext context) {
    String currentRoute =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();
    if (currentRoute == RouterProvider.adminDashboardPath()) {
      return [
        AppBarIcon(
            icon: IconPath.dataRange,
            onPress: (ctx) {
              ctx.read<DashboardCubit>().selectDate(ctx);
            }),
      ];
    } else if (currentRoute == RouterProvider.adminProductsPath()) {
      return [
        AppBarIcon(
            icon: IconPath.filter,
            onPress: (ctx) {
              moxyPrint('filter');
            })
      ];
    } else if (currentRoute == RouterProvider.adminOrdersPath()) {
      return [
        AppBarIcon(
            icon: IconPath.filter,
            onPress: (ctx) {
              ctx.push(RouterProvider.adminFilterOrderPath());
            })
      ];
    } else if (currentRoute == RouterProvider.adminFilterOrderPath()) {
      return [
        AppBarIcon(
            icon: IconPath.bag,
            text: AppLocalizations.of(context)!.reset,
            onPress: (ctx) {
              ctx.read<FilterOrdersCubit>().resetFilter();
            })
      ];
    }
    return [];
  }

  Widget _buildFabWidget(BuildContext context) {
    String currentRoute =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();

    bool shouldHideFabActions =
        currentRoute == RouterProvider.adminCreateProductPath() ||
            currentRoute == RouterProvider.adminCreateOrderPath() ||
            currentRoute == RouterProvider.adminCreateUserPath() ||
            currentRoute == RouterProvider.adminOrderProductListPath() ||
            currentRoute == RouterProvider.adminFilterOrderPath() ||
            isEditOrderRoute(currentRoute) ||
            isEditProductRoute(currentRoute);
    if (shouldHideFabActions) {
      return Container();
    }

    return ExpandableFab(distance: 100, children: [
      ActionButton(
        icon: const Icon(
          Icons.add_shopping_cart,
          size: 20,
          color: Colors.white,
        ),
        onPressed: () {
          context.push(RouterProvider.adminCreateOrderPath());
        },
      ),
      ActionButton(
        icon: const Icon(
          Icons.person_add,
          size: 20,
          color: Colors.white,
        ),
        onPressed: () {
          context.push(RouterProvider.adminCreateUserPath());
        },
      ),
      ActionButton(
        icon: const Icon(
          Icons.card_giftcard,
          size: 20,
          color: Colors.white,
        ),
        onPressed: () {
          context.push(RouterProvider.adminCreateOrderPath());
        },
      ),
    ]);
  }

  bool isEditOrderRoute(String currentRoute) {
    return currentRoute
        .startsWith('/${Routes.adminOrders}/${Routes.adminEditOrder}/');
  }

  bool isEditProductRoute(String currentRoute) {
    return currentRoute
        .startsWith('/${Routes.adminProducts}/${Routes.adminEditProduct}/');
  }
}

class AppBarIcon {
  final String icon;
  final String? text;
  final bool? loader;
  final Function(BuildContext ctx) onPress;
  const AppBarIcon(
      {required this.icon, this.text, this.loader, required this.onPress});
}
