import 'package:flutter/material.dart';
import 'package:moxy/services/navigation/root_router_cubit.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late RootRouterCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<RootRouterCubit>();
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
