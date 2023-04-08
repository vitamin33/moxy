

import 'package:flutter/material.dart';
import 'package:moxy/components/app_scaffold.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbar: AppBar(
        title: const Text("Products"),
      ),
      body: Container(),
    );
  }
}
