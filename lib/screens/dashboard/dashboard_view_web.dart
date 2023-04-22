
import 'package:flutter/material.dart';
import 'package:moxy/domain/dashboard/dashboard_cubit.dart';
import 'package:provider/provider.dart';
import '../../components/app_scaffold.dart';
import '../../services/navigation_service.dart';
import 'components/navigation_drawer.dart';

class DashboardViewWeb extends StatelessWidget {
  final String currentPath;
  const DashboardViewWeb({Key? key, required this.currentPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DashboardCubit>();

    return AppScaffold(
      body: Row(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: cubit.navigationService.showNavigationBar,
            builder: (context, show, _) {
              if (!show) return const SizedBox.shrink();
              return const DashboardDrawer();
            },
          ),
          Expanded(
            child: ClipRRect(
              child: Navigator(
                key: cubit.navigationService.navigatorKey,
                observers: [RouteObservers()],
                initialRoute: currentPath,
                onGenerateRoute: cubit.navigationService.onGeneratedRoute,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
