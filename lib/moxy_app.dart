import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moxy/domain/auth/login_cubit.dart';
import 'package:moxy/domain/dashboard/dashboard_cubit.dart';
import 'package:moxy/route_delegates.dart';
import 'package:moxy/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoxyApp extends StatelessWidget {
  const MoxyApp({Key? key}) : super(key: key);

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
      ],
      child: MaterialApp.router(
        theme: AppTheme.theme,
        title: 'Moxy Admin Panel',
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.space): const ActivateIntent(),
        },
        debugShowCheckedModeBanner: false,
        routerDelegate: UrlHandlerRouterDelegate(),
        routeInformationParser: UrlHandlerInformationParser(),
      ),
    );
  }
}
