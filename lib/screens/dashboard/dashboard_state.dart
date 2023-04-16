import 'package:moxy/services/navigation_service.dart';
import '../../components/base_state.dart';
import '../../services/get_it.dart';

class DashboardState extends BaseState {
  final navigationService = locate<NavigationService>();
}
