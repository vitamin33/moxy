import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/all_products/all_products_cubit.dart';
import 'package:moxy/domain/all_products/all_products_state.dart';
import 'package:moxy/domain/create_product/create_product_cubit.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/navigation/home_router_cubit.dart';

import '../../../../components/snackbar_widgets.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllProductsCubit, AllProductsState>(
        listener: (context, state) {
      if (state.errorMessage != '') {
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBarWhenFailure(snackBarFailureText: 'Failed'));
        context.read<CreateProductCubit>().clearErrorState();
      }
    }, builder: (context, state) {
      return Scaffold(
          body: Column(children: [
        Expanded(
          child: state.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.allProducts.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = state.allProducts[index];
                        return Card(
                          margin: const EdgeInsets.all(3.0),
                          child: ListTile(
                            leading: _buildProductImage(product),
                            title: Text(product.name),
                            trailing: listTileTrailing(state, product),
                            onTap: () {
                              context.read<HomeRouterCubit>().navigateTo(
                                    CreateProductPageState(
                                      editProductId: product.id,
                                      isEditMode: true,
                                    ),
                                  );
                            },
                          ),
                        );
                      }),
                ),
        ),
      ]));
    });
  }

  Widget _buildProductImage(Product product) {
    if (product.images.isNotEmpty) {
      return FadeInImage.assetNetwork(
        placeholder: 'assets/images/placeholder.jpg',
        image: product.images.first.imagePath,
        width: 50,
        height: 50,
      );
    } else {
      return Image.asset(
          width: 50, height: 50, 'assets/images/placeholder.jpg');
    }
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
            Text(' ${product.salePrice.toString()} \$'),
          ],
        ),
      ],
    ),
  );
}
