import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/ui/screens/client/web/root_web.dart';

class RootView extends StatelessWidget {
  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  /// The children (branch Navigators) to display in a custom container
  final List<Widget> children;

  const RootView({
    super.key,
    required this.navigationShell,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return RootWebWidget(navigationShell: navigationShell, children: children);
  }
}
