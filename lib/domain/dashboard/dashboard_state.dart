import 'package:moxy/domain/copyable.dart';

class DashboardState implements Copyable<DashboardState> {
  final bool showDrawer;

  DashboardState({required this.showDrawer});

  static defaultDashboardState() {
    return DashboardState(showDrawer: false);
  }

  @override
  DashboardState copyWith({bool? showDrawer}) {
    return DashboardState(showDrawer: showDrawer ?? this.showDrawer);
  }
}
