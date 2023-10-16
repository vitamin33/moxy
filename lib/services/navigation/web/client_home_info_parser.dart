import 'package:flutter/material.dart';
import 'package:moxy/services/navigation/web/client_home_router_cubit.dart';

class ClientHomeRouteInfoParser
    extends RouteInformationParser<ClientHomeRoute> {
  @override
  RouteInformation? restoreRouteInformation(ClientHomeRoute configuration) {
    final path = '/$shopPrefix${Uri.parse(configuration.urlPath())}';

    return RouteInformation(uri: Uri.parse(path));
  }

  @override
  Future<ClientHomeRoute> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = routeInformation.uri;
    return ClientHomeRoute.fromUri(uri);
  }
}
