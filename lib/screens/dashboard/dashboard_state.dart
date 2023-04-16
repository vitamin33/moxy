import 'package:moxy/constant/route_name.dart';
import 'package:moxy/services/navigation_service.dart';
import '../../components/base_state.dart';
import '../../data/repositories/user_repository.dart';
import '../../services/get_it.dart';

class DashboardState extends BaseState {
  final userRepo = locate<UserRepository>();
  final navigationService = locate<NavigationService>();
}
