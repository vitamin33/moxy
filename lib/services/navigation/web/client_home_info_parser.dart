import 'package:flutter/material.dart';
import 'package:moxy/services/navigation/web/client_home_router_cubit.dart';

class ClientHomeRouteInfoParser
    extends RouteInformationParser<ClientHomeRoute> {
  @override
  RouteInformation? restoreRouteInformation(ClientHomeRoute configuration) {
    final location = '/$shopPrefix${Uri.parse(configuration.urlPath())}';
    return RouteInformation(location: location);
  }

  @override
  Future<ClientHomeRoute> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    return ClientHomeRoute.fromUri(uri);
  }
}
