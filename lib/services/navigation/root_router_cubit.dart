import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/data/repositories/auth_repository.dart';
import 'package:moxy/data/repositories/config_repository.dart';
import 'package:moxy/utils/extensions.dart';

import '../../domain/roles.dart';
import '../get_it.dart';

part 'root_router_state.dart';

class RootRouterCubit extends Cubit<RootRoute> {
  final _authRepository = locate<AuthRepository>();
  final _configRepository = locate<ConfigRepository>();

  RootRouterCubit() : super(const SplashRoute());

  void goToAdminFlow([String? text]) => emit(AdminHomeRoute(text));
  void goToClientHomeFlow([String? text]) => emit(ShopRoute(text));
  void goToAuthFlow([String? text]) => emit(LoginRoute(text));
  void goToSplash([String? text]) => emit(const SplashRoute());

  void popExtra() {
    if (state is AdminHomeRoute) {
      goToAdminFlow();
    } else if (state is LoginRoute) {
      goToAuthFlow();
    }
  }

  void _checkAuthenticationAndLoadConfigurations() async {
    bool isAuthenticated = await _authRepository.checkLoggedInState();
    bool configurationsLoaded = await _configRepository.hasConfig();

    if (isAuthenticated && configurationsLoaded) {
      Role? userRole = await _authRepository.getUserRole();
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
    } else if (!configurationsLoaded) {
      goToSplash();
      bool loaded = await _configRepository.loadConfig();
      if (loaded) {
        _checkAuthenticationAndLoadConfigurations();
      }
    } else {
      goToAuthFlow();
    }
  }

  void checkInitialState() {
    _checkAuthenticationAndLoadConfigurations();
  }
}
