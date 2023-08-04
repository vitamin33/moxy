import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moxy/domain/admin/filter_orders/filter_orders_cubit.dart';
import 'package:moxy/domain/auth/login_cubit.dart';
import 'package:moxy/domain/admin/create_order/create_order_cubit.dart';
import 'package:moxy/domain/admin/dashboard/dashboard_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'domain/admin/all_orders/all_orders_cubit.dart';
import 'domain/admin/all_products/all_products_cubit.dart';
import 'domain/admin/edit_order/edit_order_cubit.dart';
import 'services/navigation/admin_home_router_cubit.dart';
import 'services/navigation/root_router_cubit.dart';
import 'services/navigation/root_router_delegate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        BlocProvider<FilterOrdersCubit>(
            create: (BuildContext context) => FilterOrdersCubit()),
      ],
      child: MaterialApp(
        home: _routers,
        theme: theme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
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
