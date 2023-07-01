import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/data/repositories/auth_repository.dart';
import 'package:moxy/utils/extensions.dart';

import '../../domain/roles.dart';
import '../get_it.dart';

part 'root_router_state.dart';

class RootRouterCubit extends Cubit<RootRouterState> {
  final authRepository = locate<AuthRepository>();

  RootRouterCubit() : super(const AuthPageState()) {
    _checkLoggedInState();
  }
  void goToAdminFlow([String? text]) => emit(AdminPageState(text));
  void goToClientFlow([String? text]) => emit(ClientPageState(text));
  void goToAuthFlow([String? text]) => emit(AuthPageState(text));
  void popExtra() {
    if (state is AdminPageState) {
      goToAdminFlow();
    } else if (state is AuthPageState) {
      goToAuthFlow();
    }
  }

  _checkLoggedInState() async {
    bool isLoggedIn = await authRepository.checkLoggedInState();
    if (isLoggedIn) {
      Role? userRole = await authRepository.getUserRole();
      userRole?.let(
        (role) {
          switch (role) {
            case Role.admin:
            case Role.manager:
              goToAdminFlow();
              break;
            case Role.user:
            case Role.guest:
              goToClientFlow();
              break;
          }
        },
      );
    } else {
      goToAuthFlow();
    }
  }
}
