import 'package:flutter/material.dart';
import 'package:moxy/domain/dashboard/dashboard_cubit.dart';
import 'package:provider/provider.dart';
import '../../components/app_scaffold.dart';
import '../../services/navigation_service.dart';
import 'components/navigation_drawer.dart';

class DashboardViewMobile extends StatelessWidget {
  final String currentPath;
  const DashboardViewMobile({Key? key, required this.currentPath})
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
                return AppScaffold(
                  appbar: AppBar(
                    title: Row(children: [
                      Text(title),
                    ]),
                    leading: Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          tooltip: 'Open side bar',
                        );
                      },
                    ),
                  ),
                  drawer: const DashboardDrawer(),
                  body: Navigator(
                    key: cubit.navigationService.navigatorKey,
                    observers: [RouteObservers()],
                    initialRoute: currentPath,
                    onGenerateRoute: cubit.navigationService.onGeneratedRoute,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
