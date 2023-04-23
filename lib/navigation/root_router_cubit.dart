import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/auth_repository.dart';
import '../services/get_it.dart';

part 'root_router_state.dart';

class RootRouterCubit extends Cubit<RootRouterState> {
  final authRepository = locate<AuthRepository>();

  RootRouterCubit() : super(const AuthPageState()) {
    _checkLoggedInState();
  }
  void goToMain([String? text]) => emit(MainPageState(text));
  void goToAuth([String? text]) => emit(AuthPageState(text));
  void popExtra() {
    if (state is MainPageState) {
      goToMain();
    } else if (state is AuthPageState) {
      goToAuth();
    }
  }

  _checkLoggedInState() async {
    bool isLoggedIn = await authRepository.checkLoggedInState();
    if (isLoggedIn) {
      goToMain();
    } else {
      goToAuth();
    }
  }
}
