import 'package:flutter/material.dart';
import 'package:moxy/services/navigation/root_router_cubit.dart';

import '../../utils/common.dart';

class RootRouteInfoParser extends RouteInformationParser<RootRoute> {
  @override
  RouteInformation? restoreRouteInformation(RootRoute configuration) {
    final location = '/${Uri.parse(configuration.urlPath())}';
    moxyPrint('ROOT_restoreRouteInformation() called, location = $location');

    return RouteInformation(location: location);
  }

  @override
  Future<RootRoute> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    moxyPrint('ROOT_parseRouteInformation() called, uri = $uri');

    return RootRoute.fromUri(uri);
  }
}
