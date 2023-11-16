import 'package:flutter/material.dart';
import 'package:moxy/domain/admin/filter_orders/filter_orders_cubit.dart';
import 'package:moxy/domain/auth/login_cubit.dart';
import 'package:moxy/domain/admin/create_order/create_order_cubit.dart';
import 'package:moxy/domain/admin/dashboard/dashboard_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/auth/registration/registration_cubit.dart';
import 'package:moxy/domain/client/basket/basket_cubit.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/services/navigation/splash/root_router_cubit.dart';
import 'package:moxy/ui/theme/theme_provider.dart';
import 'domain/admin/all_orders/all_orders_cubit.dart';
import 'domain/admin/all_products/all_products_cubit.dart';
import 'domain/admin/edit_order/edit_order_cubit.dart';
import 'services/navigation/admin/admin_home_router_cubit.dart';
import 'services/navigation/web/client_home_router_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

// ignore: must_be_immutable
class MoxyApp extends StatelessWidget {
  AppThemeData theme;
  MoxyApp(this.theme, {Key? key}) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider<RegistrationCubit>(
          create: (BuildContext context) => RegistrationCubit(),
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
        BlocProvider<ClientHomeRouterCubit>(
          create: (BuildContext context) => ClientHomeRouterCubit(),
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
        BlocProvider<BasketCubit>(
          create: (BuildContext context) => BasketCubit(),
        )
      ],
      child: BlocBuilder<RootRouterCubit, RootRoute>(builder: (context, state) {
        return MaterialApp.router(
          routeInformationProvider:
              RouterProvider.router.routeInformationProvider,
          routeInformationParser: RouterProvider.router.routeInformationParser,
          routerDelegate: RouterProvider.router.routerDelegate,
          backButtonDispatcher: RootBackButtonDispatcher(),
          theme: theme.theme,
          darkTheme: theme.darkTheme,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        );
      }),
    );
  }
}
