import 'dart:async';

import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  final _eventController = StreamController<NavigationEvent>.broadcast();

  Stream<NavigationEvent> get eventStream => _eventController.stream;

  void sendNavEvent(NavigationEvent event) {
    _eventController.sink.add(event);
  }

  final _authRepository = locate<AuthRepository>();
  final _configRepository = locate<ConfigRepository>();

  RootRouterCubit() : super(const SplashRoute()) {
    checkInitialState();
  }

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
    bool configurationsLoaded = await _configRepository.hasConfig();

    if (configurationsLoaded) {
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
        goToClientHomeFlow();
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
