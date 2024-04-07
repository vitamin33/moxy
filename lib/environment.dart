import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName => kReleaseMode ? ".prod.env" : ".dev.env";
  static String get apiUrl => dotenv.env['BASE_URL'] ?? 'http://34.118.78.215';
  static String get monoAcquiringToken =>
      dotenv.env['MONO_ACQUIRING_TOKEN'] ?? '';
}
