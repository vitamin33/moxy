import 'dart:html';

import 'package:flutter/material.dart';
import 'package:moxy/components/app_scaffold.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbar: AppBar(
        title: const Text("Customers"),
      ),
      body: Container(),
    );
  }
}
