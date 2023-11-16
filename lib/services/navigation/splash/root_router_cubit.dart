import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:moxy/data/repositories/auth_repository.dart';
import 'package:moxy/data/repositories/config_repository.dart';
import 'package:moxy/domain/roles.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/services/navigation/navigation_event.dart';
import 'package:moxy/services/navigation/splash/splash_effects.dart';
import 'package:moxy/utils/extensions.dart';

part 'root_router_state.dart';

class RootRouterCubit extends CubitWithEffects<RootRoute, UiEffect> {
  final _eventController = StreamController<NavigationEvent>.broadcast();

  Stream<NavigationEvent> get eventStream => _eventController.stream;

  void sendNavEvent(NavigationEvent event) {
    _eventController.sink.add(event);
  }

  final _authRepository = locate<AuthRepository>();
  final _configRepository = locate<ConfigRepository>();

  RootRouterCubit() : super(const SplashRoute());

  void goToAdminFlow([String? text]) => emitEffect(NavigateAdminRoot());
  void goToClientHomeFlow([String? text]) => emitEffect(NavigateClientRoot());
  void goToAuthFlow([String? text]) => emitEffect(NavigateAuthRoot());
  void goToSplash([String? text]) => emitEffect(NavigateSplash());

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

  @override
  Future<void> close() {
    _eventController.close();
    return super.close();
  }
}
