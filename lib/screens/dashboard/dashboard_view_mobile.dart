import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/dashboard/dashboard_cubit.dart';
import '../../components/app_scaffold.dart';
import '../../domain/auth/login_cubit.dart';
import '../../domain/auth/login_state.dart';
import '../../services/navigation_service.dart';
import '../../utils/common.dart';
import 'components/navigation_drawer.dart';

class DashboardViewMobile extends StatelessWidget {
  final String currentPath;
  const DashboardViewMobile({Key? key, required this.currentPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DashboardCubit>();
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) =>
          {moxyPrint('DashboarViewMobile, state: $state')},
      buildWhen: (previous, current) => previous.state != current.state,
      builder: (context, state) => Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (context) {
              return ValueListenableBuilder<String>(
                valueListenable: cubit.navigationService.titleNotifier,
                builder: (context, title, _) {
                  final isAuthorized = state is LoginWithCredsSuccess;
                  return authenticatedWidget(cubit, title, isAuthorized);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget authenticatedWidget(
      DashboardCubit cubit, String title, bool isAuthorized) {
    return AppScaffold(
      appbar: AppBar(
        title: Row(children: [
          Text(title),
        ]),
        leading: isAuthorized
            ? Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip: 'Open side bar',
                  );
                },
              )
            : null,
      ),
      drawer: isAuthorized ? const DashboardDrawer() : null,
      body: Navigator(
        key: cubit.navigationService.navigatorKey,
        observers: [RouteObservers()],
        initialRoute: currentPath,
        onGenerateRoute: cubit.navigationService.onGeneratedRoute,
      ),
    );
  }
}
