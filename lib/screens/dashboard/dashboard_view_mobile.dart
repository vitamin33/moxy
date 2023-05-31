import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/dashboard/dashboard_cubit.dart';
import 'package:moxy/navigation/home_router_delegate.dart';
import 'package:moxy/theme/app_theme.dart';
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
    return AppScaffold(
        appbar: AppBar(
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
}
