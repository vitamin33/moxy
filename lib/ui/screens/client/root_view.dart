import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/src/route.dart';
import 'package:moxy/ui/screens/client/web/root_web.dart';

import 'mobile/root_mobile.dart';

class RootView extends StatelessWidget {
  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  /// The children (branch Navigators) to display in a custom container
  final List<Widget> children;

  const RootView({
    Key? key,
    required this.navigationShell,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return RootWebWidget(
          navigationShell: navigationShell, children: children);
    } else {
      return const RootMobileWidget();
    }
  }
}
