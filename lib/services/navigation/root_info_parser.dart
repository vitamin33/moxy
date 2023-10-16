import 'package:flutter/material.dart';
import 'package:moxy/services/navigation/root_router_cubit.dart';

class RootRouteInfoParser extends RouteInformationParser<RootRoute> {
  @override
  RouteInformation? restoreRouteInformation(RootRoute configuration) {
    final path = '/${Uri.parse(configuration.urlPath())}';
    return RouteInformation(uri: Uri.parse(path));
  }

  @override
  Future<RootRoute> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = routeInformation.uri;
    return RootRoute.fromUri(uri);
  }
}
