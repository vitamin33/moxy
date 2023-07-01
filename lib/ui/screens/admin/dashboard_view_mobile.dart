import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/services/navigation/admin_home_router_cubit.dart';
import 'package:moxy/services/navigation/admin_home_router_delegate.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';
import '../../components/app_scaffold.dart';
import 'components/action_button.dart';
import 'components/flutter_expandable_fab.dart';
import 'components/navigation_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardViewMobile extends StatelessWidget {
  DashboardViewMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (context) {
            return BlocBuilder<AdminHomeRouterCubit, AdminHomeRouterState>(
                builder: (context, state) => mobileWidget(context, state));
          },
        ),
      ],
    );
  }

  Widget mobileWidget(BuildContext context, AdminHomeRouterState state) {
    final arrIcons = _mapStateToActionIcon(state);

    return AppScaffold(
      appbar: AppBar(
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
                                width: 38,
                                height: 38,
                                child: InkWell(
                                  onTap: () {
                                    item.onPress();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SvgPicture.asset(item.icon),
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
        backgroundColor: state.runtimeType == EditOrderPageState
            ? AppTheme.white
            : AppTheme.pink,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            _mapStateToTitleText(state),
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            if (state.runtimeType == OrderProductListPageState) {
              return IconButton(
                  onPressed: () {
                    context.read<AdminHomeRouterCubit>().navigateTo(
                          const CreateOrderPageState(),
                        );
                  },
                  icon: SvgPicture.asset(IconPath.backArrow));
            } else if (state.runtimeType == EditOrderPageState) {
              return IconButton(
                  onPressed: () {
                    context.read<AdminHomeRouterCubit>().navigateTo(
                          const OrdersPageState(),
                        );
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
      floatingActionButton: _buildFabWidget(context, state),
      body: _routers,
    );
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Widget get _routers =>
      BlocBuilder<AdminHomeRouterCubit, AdminHomeRouterState>(
        builder: (context, state) => Router(
          routerDelegate: AdminHomeRouterDelegate(
            navigatorKey,
            context.read<AdminHomeRouterCubit>(),
          ),
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      );

  String _mapStateToTitleText(AdminHomeRouterState state) {
    switch (state.runtimeType) {
      case OverviewPageState:
        return 'Dashboard';
      case ProductsPageState:
        return 'Products';
      case UsersPageState:
        return 'Customers';
      case OrdersPageState:
        return 'Orders';
      case CreateProductPageState:
        final createProductState = state as CreateProductPageState;
        if (createProductState.isEditMode ?? false) {
          return 'Edit product';
        } else {
          return 'Create product';
        }
      case CreateOrderPageState:
        return 'Create order';
      case EditOrderPageState:
        return 'Edit Order';
      case OrderProductListPageState:
        return 'Order Product List';
      case CreateUserPageState:
        return 'Create user';
      case TransactionsPageState:
        return 'Products';
      case FeedbacksPageState:
        return 'Feedbacks';
    }
    return 'Dashboard';
  }

  List<AppBarIcon> _mapStateToActionIcon(AdminHomeRouterState state) {
    switch (state.runtimeType) {
      case OverviewPageState:
        return [];
      case ProductsPageState:
        return [
          AppBarIcon(
              icon: IconPath.plus,
              onPress: () {
                moxyPrint('plus');
              }),
          AppBarIcon(
              icon: IconPath.filter,
              onPress: () {
                moxyPrint('filter');
              })
        ];
      case UsersPageState:
        return [];
      case OrdersPageState:
        return [];
      case CreateProductPageState:
        return [];
      case CreateOrderPageState:
        return [];
      case TransactionsPageState:
        return [];
      case FeedbacksPageState:
        return [];
    }
    return [];
  }

  Widget _buildFabWidget(BuildContext context, AdminHomeRouterState state) {
    switch (state.runtimeType) {
      case CreateProductPageState:
      case CreateUserPageState:
      case CreateOrderPageState:
      case EditOrderPageState:
        return Container();
    }
    return ExpandableFab(distance: 100, children: [
      ActionButton(
        icon: const Icon(
          Icons.add_business,
          color: Colors.white,
        ),
        onPressed: () {
          context
              .read<AdminHomeRouterCubit>()
              .navigateTo(const CreateOrderPageState());
        },
      ),
      ActionButton(
        icon: const Icon(
          Icons.people,
          color: Colors.white,
        ),
        onPressed: () {
          context
              .read<AdminHomeRouterCubit>()
              .navigateTo(const CreateUserPageState());
        },
      ),
      ActionButton(
        icon: const Icon(
          Icons.add_box,
          color: Colors.white,
        ),
        onPressed: () {
          context
              .read<AdminHomeRouterCubit>()
              .navigateTo(const CreateProductPageState());
        },
      ),
    ]);
  }
}

class AppBarIcon {
  final String icon;
  final Function() onPress;
  const AppBarIcon({required this.icon, required this.onPress});
}
