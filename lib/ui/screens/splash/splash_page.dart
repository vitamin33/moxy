import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/services/navigation/splash/root_router_cubit.dart';
import 'package:moxy/services/navigation/splash/splash_effects.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late RootRouterCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<RootRouterCubit>();
    cubit.effectStream.listen((effect) {
      if (effect is NavigateAdminRoot) {
        context.go(RouterProvider.adminDashboardPath());
      } else if (effect is NavigateClientRoot) {
        context.go(RouterProvider.homeNewPath());
      } else if (effect is NavigateAuthRoot) {
        context.go(RouterProvider.loginPath());
      }
    });
    cubit.checkInitialState();
  }

  @override
  Widget build(BuildContext context) {
    Widget logo = Image.asset(
      'assets/icons/moxy_icon.png',
      width: 150,
      height: 150,
    );

    return Scaffold(
      body: Center(
        child: logo,
      ),
    );
  }
}
