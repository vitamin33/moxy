import 'package:flutter/material.dart';
import 'package:moxy/services/navigation/root_router_cubit.dart';

class RootRouteInfoParser extends RouteInformationParser<RootRoute> {
  @override
  RouteInformation? restoreRouteInformation(RootRoute configuration) {
    final location = '/${Uri.parse(configuration.urlPath())}';
    return RouteInformation(location: location);
  }

  @override
  Future<RootRoute> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    return RootRoute.fromUri(uri);
  }
}
