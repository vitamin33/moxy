import 'package:flutter/material.dart';
import 'package:moxy/domain/auth/login_cubit.dart';
import 'package:moxy/domain/create_product/create_product_cubit.dart';
import 'package:moxy/domain/dashboard/dashboard_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/all_orders/all_orders_cubit.dart';
import 'domain/all_products/all_products_cubit.dart';
import 'navigation/root_router_cubit.dart';
import 'navigation/root_router_delegate.dart';
import 'navigation/home_router_cubit.dart';

class MoxyApp extends StatelessWidget {
  ThemeData theme;
  ThemeData darkTheme;
  MoxyApp(this.theme, this.darkTheme, {Key? key}) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider<DashboardCubit>(
          create: (BuildContext context) => DashboardCubit(),
        ),
        BlocProvider<RootRouterCubit>(
          create: (BuildContext context) => RootRouterCubit(),
        ),
        BlocProvider<HomeRouterCubit>(
          create: (BuildContext context) => HomeRouterCubit(),
        ),
        BlocProvider<AllProductsCubit>(
            create: (BuildContext context) => AllProductsCubit()),
        BlocProvider<AllOrdersCubit>(
            create: (BuildContext context) => AllOrdersCubit()),
      ],
      child: MaterialApp(
        home: _routers,
        theme: theme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  Widget get _routers => BlocBuilder<RootRouterCubit, RootRouterState>(
        builder: (context, state) => Router(
          routerDelegate: RootRouterDelegate(
            navigatorKey,
            context.read<RootRouterCubit>(),
          ),
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      );
}
