import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/data/repositories/auth_repository.dart';

import '../get_it.dart';

part 'root_router_state.dart';

class RootRouterCubit extends Cubit<RootRouterState> {
  final authRepository = locate<AuthRepository>();

  RootRouterCubit() : super(const AuthPageState()) {
    _checkLoggedInState();
  }
  void goToAdmin([String? text]) => emit(AdminPageState(text));
  void goToAuth([String? text]) => emit(AuthPageState(text));
  void popExtra() {
    if (state is AdminPageState) {
      goToAdmin();
    } else if (state is AuthPageState) {
      goToAuth();
    }
  }

  _checkLoggedInState() async {
    bool isLoggedIn = await authRepository.checkLoggedInState();
    if (isLoggedIn) {
      goToAdmin();
    } else {
      goToAuth();
    }
  }
}
