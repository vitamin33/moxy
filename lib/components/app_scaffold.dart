import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appbar;
  final Widget body;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const AppScaffold(
      {Key? key,
      required this.body,
      this.appbar,
      this.drawer,
      this.endDrawer,
      this.floatingActionButton,
      this.bottomNavigationBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppTheme.size(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: appbar,
      endDrawer: endDrawer,
      backgroundColor: theme.primaryColorLight,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1.5,
            colors: [
              theme.primaryColorLight,
              theme.primaryColorDark,
            ],
          ),
        ),
        child: body,
      ),
    );
  }
}
