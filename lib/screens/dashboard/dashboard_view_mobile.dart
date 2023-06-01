import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/navigation/home_router_delegate.dart';
import 'package:moxy/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';
import '../../components/app_scaffold.dart';
import '../../navigation/home_router_cubit.dart';
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
            return BlocBuilder<HomeRouterCubit, HomeRouterState>(
                builder: (context, state) => mobileWidget(state));
          },
        ),
      ],
    );
  }

  Widget mobileWidget(HomeRouterState state) {
    final arrIcon = _mapStateToActionIcon(state);
    return AppScaffold(
        appbar: AppBar(
          actions: [
            arrIcon.isNotEmpty
                ? SizedBox(
                    width: 70,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: arrIcon.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    arrIcon[index].onPress();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child:
                                        SvgPicture.asset(arrIcon[index].icon),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                : Container()
          ],
          backgroundColor: AppTheme.pink,
          title: Text(_mapStateToTitleText(state)),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: SvgPicture.asset(IconPath.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: 'Open side bar',
              );
            },
          ),
        ),
        drawer: const DashboardDrawer(),
        body: _routers);
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Widget get _routers => BlocBuilder<HomeRouterCubit, HomeRouterState>(
        builder: (context, state) => Router(
          routerDelegate: HomeRouterDelegate(
            navigatorKey,
            context.read<HomeRouterCubit>(),
          ),
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      );

  String _mapStateToTitleText(HomeRouterState state) {
    switch (state.runtimeType) {
      case OverviewPageState:
        return 'Dashboard';
      case ProductsPageState:
        return 'Products';
      case CustomersPageState:
        return 'Customers';
      case OrdersPageState:
        return 'Orders';
      case CreateProductPageState:
        return 'Створити продукт ';
      case CreateOrderPageState:
        return 'Create order';
      case TransactionsPageState:
        return 'Products';
      case FeedbacksPageState:
        return 'Feedbacks';
    }
    return 'Dashboard';
  }

  List<AppBarIcon> _mapStateToActionIcon(HomeRouterState state) {
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
                moxyPrint('folter');
              })
        ];
      case CustomersPageState:
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
}

class AppBarIcon {
  final String icon;
  final Function() onPress;
  const AppBarIcon({required this.icon, required this.onPress});
}
