import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moxy/firebase_options.dart';
import 'package:moxy/moxy_app.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    GetItService.initializeService();
    runApp(const MoxyApp());
  }, (error, stack) => moxyPrint(error));
}
