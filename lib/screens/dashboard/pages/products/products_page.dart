import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/all_products/all_products_cubit.dart';
import 'package:moxy/domain/all_products/all_products_state.dart';


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
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: allProducts.length,
                        itemBuilder: (BuildContext context, int index) {
                          final product = allProducts[index];
                          return ListTile(
                            title: Text(product.name),
                            subtitle: Text(product.description),
                            trailing: Text(product.salePrice.toString()),
                          );
                        });
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
