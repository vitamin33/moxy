import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/dashboard/dashboard_cubit.dart';
import 'package:moxy/navigation/home_router_delegate.dart';
import '../../components/app_scaffold.dart';
import '../../navigation/home_router_cubit.dart';
import 'components/navigation_drawer.dart';

class DashboardViewMobile extends StatelessWidget {
  DashboardViewMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DashboardCubit>();
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (context) {
            return ValueListenableBuilder<String>(
              valueListenable: cubit.navigationService.titleNotifier,
              builder: (context, title, _) {
                return mobileWidget(cubit, title);
              },
            );
          },
        ),
      ],
    );
  }

  Widget mobileWidget(DashboardCubit cubit, String title) {
    return AppScaffold(
        appbar: AppBar(
          title: Row(children: [
            Text(title),
          ]),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
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
}
