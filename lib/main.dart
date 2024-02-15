import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:moxy/moxy_app.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/services/navigation/navigation_service.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/ui/theme/app_theme.dart';

import 'package:moxy/utils/common.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';

import 'environment.dart';
import 'ui/theme/theme_provider.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    await dotenv.load(fileName: Environment.fileName);
    WidgetsFlutterBinding.ensureInitialized();

    final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
    final themeDarkStr =
        await rootBundle.loadString('assets/appainter_theme.json');
    final themeJson = jsonDecode(themeStr);
    final themeDarkJson = jsonDecode(themeDarkStr);
    final theme = ThemeDecoder.decodeThemeData(themeJson)!;
    final darkTheme = ThemeDecoder.decodeThemeData(themeDarkJson)!;
    final appThemeData = AppThemeData(
      theme.copyWith(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppTheme.pink,
          foregroundColor: AppTheme.black,
        ),
      ),
      darkTheme,
    );

    GetItService.initializeService();
    initNavigationSercie();

    runApp(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(appThemeData),
        child: AppTheme(
          child: MoxyApp(appThemeData),
        ),
      ),
    );
  }, (error, stack) => moxyPrint(error));

  if (kIsWeb) {
    usePathUrlStrategy();
  }
}

void initNavigationSercie() {
  final navService = locate<NavigationService>();
  navService.router = RouterProvider.router;
}
 