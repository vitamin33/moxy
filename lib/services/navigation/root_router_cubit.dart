import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/data/repositories/auth_repository.dart';
import 'package:moxy/utils/extensions.dart';

import '../../domain/roles.dart';
import '../get_it.dart';

part 'root_router_state.dart';

class RootRouterCubit extends Cubit<RootRoute> {
  final authRepository = locate<AuthRepository>();

  RootRouterCubit() : super(const LoginRoute()) {
    _checkLoggedInState();
  }
  void goToAdminFlow([String? text]) => emit(AdminHomeRoute(text));
  void goToClientHomeFlow([String? text]) => emit(ShopRoute(text));
  void goToAuthFlow([String? text]) => emit(LoginRoute(text));

  void popExtra() {
    if (state is AdminHomeRoute) {
      goToAdminFlow();
    } else if (state is LoginRoute) {
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
              goToClientHomeFlow();
              break;
          }
        },
      );
    } else {
      goToAuthFlow();
    }
  }
}
