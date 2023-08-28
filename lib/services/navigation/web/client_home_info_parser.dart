import 'package:flutter/material.dart';
import 'package:moxy/services/navigation/web/client_home_router_cubit.dart';
import 'package:moxy/utils/common.dart';

class ClientHomeRouteInfoParser
    extends RouteInformationParser<ClientHomeRoute> {
  @override
  RouteInformation? restoreRouteInformation(ClientHomeRoute configuration) {
    final location = '/$shopPrefix${Uri.parse(configuration.urlPath())}';
    moxyPrint('CLIENT_restoreRouteInformation() called, location = $location');

    return RouteInformation(location: location);
  }

  @override
  Future<ClientHomeRoute> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    moxyPrint('CLIENT_parseRouteInformation() called, uri = $uri');

    return ClientHomeRoute.fromUri(uri);
  }
}
