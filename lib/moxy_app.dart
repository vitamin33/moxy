import 'package:flutter/material.dart';
import 'package:moxy/domain/auth/login_cubit.dart';
import 'package:moxy/domain/create_order/create_order_cubit.dart';
import 'package:moxy/domain/dashboard/dashboard_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'domain/all_orders/all_orders_cubit.dart';
import 'domain/all_products/all_products_cubit.dart';
import 'domain/edit_order/edit_order_cubit.dart';
import 'services/navigation/admin_home_router_cubit.dart';
import 'services/navigation/root_router_cubit.dart';
import 'services/navigation/root_router_delegate.dart';

// ignore: must_be_immutable
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
        BlocProvider<AdminHomeRouterCubit>(
          create: (BuildContext context) => AdminHomeRouterCubit(),
        ),
        BlocProvider<AllProductsCubit>(
            create: (BuildContext context) => AllProductsCubit()),
        BlocProvider<AllOrdersCubit>(
            create: (BuildContext context) => AllOrdersCubit()),
        BlocProvider<CreateOrderCubit>(
            create: (BuildContext context) => CreateOrderCubit()),
        BlocProvider<EditOrderCubit>(
            create: (BuildContext context) => EditOrderCubit()),
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
