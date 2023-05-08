import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/all_products/all_products_cubit.dart';
import 'package:moxy/domain/all_products/all_products_state.dart';
import 'package:moxy/theme/app_theme.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllProductsCubit, AllProductsState>(
        builder: (context, state) {
      return Scaffold(
          body: Column(
        children: [
          Expanded(
              child: state.when(
                  initial: (allProducts) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: allProducts.length,
                          itemBuilder: (BuildContext context, int index) {
                            final product = allProducts[index];
                            return Card(
                              margin: const EdgeInsets.all(3.0),
                              child: ListTile(
                                leading: Image.network(
                                  '${product.images.first}',
                                  width: 50,
                                  height: 50,
                                ),
                                title: Text(product.name),
                                trailing: listTileTrailing(state, product),
                              ),
                            );
                          }),
                    );
                  },
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                  error: (message) => Center(
                        child: Text('$message'),
                      ))),
        ],
      ));
    });
  }
}

Widget listTileTrailing(AllProductsState state, product) {
  return SizedBox(
    width: 150,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Quantity: '),
            Text('Price:  '),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(' ${product.warehouseQuantity.toString()}'),
            Text(' ${product.salePrice.toString()} \$'),
          ],
        ),
      ],
    ),
  );
}
