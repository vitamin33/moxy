import 'package:moxy/domain/copyable.dart';

class DashboardState implements Copyable<DashboardState> {
  DashboardState();

  static defaultDashboardState() {
    return DashboardState();
  }

  @override
  DashboardState copyWith() {
    return DashboardState();
  }
}
