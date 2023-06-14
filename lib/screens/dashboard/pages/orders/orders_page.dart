import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/snackbar_widgets.dart';
import '../../../../domain/all_orders/all_orders_cubit.dart';
import '../../../../domain/all_orders/all_orders_state.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllOrdersCubit, AllOrdersState>(
        listener: (context, state) {
      if (state.errorMessage != '') {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
            snackBarFailureText: 'Failed:${state.errorMessage}'));
      }
    }, builder: (context, state) {
      return Scaffold(
          body: Column(
        children: [
          Expanded(
              child: state.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.allOrders.length,
                          itemBuilder: (BuildContext context, int index) {
                            final order = state.allOrders[index];
                            return Card(
                              margin: const EdgeInsets.all(3.0),
                              child: ListTile(
                                leading: Image.network(
                                  order.products.first.images.first.imagePath,
                                  width: 50,
                                  height: 50,
                                ),
                                title: Text('${order.deliveryType}'),
                                trailing: const Icon(Icons.arrow_forward_ios),
                              ),
                            );
                          }),
                    ))
        ],
      ));
    });
  }
}
