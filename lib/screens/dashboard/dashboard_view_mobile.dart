import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/dashboard/dashboard_cubit.dart';
import '../../components/app_scaffold.dart';
import '../../services/navigation_service.dart';
import '../../utils/common.dart';
import 'components/navigation_drawer.dart';

class DashboardViewMobile extends StatelessWidget {
  final String currentPath;
  final bool isAuthorized;
  const DashboardViewMobile(
      {Key? key, required this.isAuthorized, required this.currentPath})
      : super(key: key);

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
    moxyPrint('Build mobile widget, IsAuthorized: $isAuthorized');
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
