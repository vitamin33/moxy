import 'package:flutter/material.dart';
import 'package:moxy/ui/screens/components/product_grid.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:  EdgeInsets.all(8.0),
      child: Column(
        children: [
          ProductListGrid(bigBlockLeading: false),
          ProductListGrid(bigBlockLeading: true),
        ],
      ),
    );
  }
}
