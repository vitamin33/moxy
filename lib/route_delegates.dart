import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/data/repositories/auth_repository.dart';
import 'package:moxy/domain/auth/auth_cubit.dart';
import 'package:moxy/domain/auth/auth_state.dart';
import 'package:moxy/screens/dashboard/dashboard_view_mobile.dart';
import 'package:moxy/screens/dashboard/dashboard_view_web.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/services/navigation_service.dart';
import 'package:moxy/utils/common.dart';

import 'constant/route_name.dart';

class UrlHandlerRouterDelegate extends RouterDelegate<String> {
  final authRepository = locate<AuthRepository>();
  final navigationService = locate<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthorizedState>(
        listener: (context, state) =>
            {moxyPrint('DashboarViewMobile, state: ${state.isAuthorized}')},
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) => buildPlatformWidget(state.isAuthorized));
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
    if (hasUser && configuration != authPath && configuration != root) {
      if (!navigationService.pathToCloseNavigationBar.contains(configuration)) {
        navigationService.setNavigationBar = true;
      }
      navigationService.routeNotifier.value = configuration;
      navigatePushReplaceName(configuration);
    } else {
      if (hasUser) {
        navigatePushReplaceName(overview);
      } else {
        navigatePushReplaceName(authPath);
      }
    }
  }

  Widget buildPlatformWidget(bool hasUser) {
    if (kIsWeb) {
      return DashboardViewWeb(
          currentPath: navigationService.determineHomePath(hasUser));
    } else {
      return DashboardViewMobile(
          isAuthorized: hasUser,
          currentPath: navigationService.determineHomePath(hasUser));
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
