import 'package:flutter/material.dart';
import 'package:moxy/data/repositories/auth_repository.dart';
import 'package:moxy/screens/dashboard/dashboard_view.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/services/navigation_service.dart';

import 'constant/route_name.dart';

class UrlHandlerRouterDelegate extends RouterDelegate<String> {
  final authRepository = locate<AuthRepository>();
  final navigationService = locate<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return DashboardView(currentPath: navigationService.determineHomePath());
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  Future<bool> popRoute() async {
    return false;
  }

  @override
  void removeListener(VoidCallback listener) {}

  @override
  Future<void> setNewRoutePath(configuration) async {
    bool hasUser = await authRepository.checkLoggedInState();
    if (hasUser && configuration != authPath) {
      if (!navigationService.pathToCloseNavigationBar.contains(configuration)) {
        navigationService.setNavigationBar = true;
      }
      navigationService.routeNotifier.value = configuration;
      navigatePushReplaceName(configuration);
    } else {
      if (hasUser) {
        navigatePushReplaceName(authPath);
      } else {
        navigatePushReplaceName(overview);
      }
    }
  }
}

class UrlHandlerInformationParser extends RouteInformationParser<String> {
  @override
  Future<String> parseRouteInformation(
      RouteInformation routeInformation) async {
    return "${routeInformation.location}";
  }
}
