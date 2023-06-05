import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:moxy/firebase_options.dart';
import 'package:moxy/moxy_app.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    await dotenv.load();
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
    final themeDarkStr =
        await rootBundle.loadString('assets/appainter_theme.json');
    final themeJson = jsonDecode(themeStr);
    final themeDarkJson = jsonDecode(themeDarkStr);
    final theme = ThemeDecoder.decodeThemeData(themeJson)!;
    final darkTheme = ThemeDecoder.decodeThemeData(themeDarkJson)!;

    GetItService.initializeService();
    runApp(MoxyApp(theme, darkTheme));
  }, (error, stack) => moxyPrint(error));
}
