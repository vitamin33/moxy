import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/components/app_scaffold.dart';

import '../../../../domain/all_orders/all_orders_cubit.dart';
import '../../../../domain/all_orders/all_orders_state.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllOrdersCubit, AllOrdersState>(
        builder: (context, state) {
      return Scaffold(
          body: Column(
        children: [
          Expanded(
              child: state.when(
                  initial: (allOrders) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: allOrders.length,
                          itemBuilder: (BuildContext context, int index) {
                            final order = allOrders[index];
                            return Card(
                              margin: const EdgeInsets.all(3.0),
                              child: ListTile(
                                leading: Image.network(
                                  order.products[0].images.first,
                                  width: 50,
                                  height: 50,
                                ),
                                title: Text(order.deliveryType),
                                // trailing: listTileTrailing(state, product),
                                // onTap: () {
                                //   context
                                //       .read<CreateProductCubit>()
                                //       .changeEdit();
                                //   context
                                //       .read<CreateProductCubit>()
                                //       .getProductById(product.id);
                                //   context.read<HomeRouterCubit>().navigateTo(
                                //       const CreateProductPageState());
                                // },
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

// Widget listTileTrailing(AllProductsState state, product) {
//   return SizedBox(
//     width: 150,
//     child: Row(
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Text('Quantity: '),
//             Text('Price:  '),
//           ],
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Text(' ${product.warehouseQuantity.toString()}'),
//             Text(' ${product.salePrice.toString()} \$'),
//           ],
//         ),
//       ],
//     ),
//   );

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Container(
//   //     child: const Text('Orders'),
//   //   );
//   // }
// }
