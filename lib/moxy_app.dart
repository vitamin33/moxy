import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moxy/route_delegates.dart';
import 'package:moxy/domain/authentication_state.dart';
import 'package:moxy/screens/dashboard/dashboard_state.dart';
import 'package:moxy/theme/app_theme.dart';
import 'package:provider/provider.dart';

class MoxyApp extends StatelessWidget {
  const MoxyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationState()),
        ChangeNotifierProvider(create: (context) => DashboardState()),
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
