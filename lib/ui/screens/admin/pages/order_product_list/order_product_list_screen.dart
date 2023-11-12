import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/admin/order_product_list/order_product_list_cubit.dart';
import 'package:moxy/domain/admin/order_product_list/order_product_list_state.dart';
import 'package:moxy/ui/components/snackbar_widgets.dart';
import 'package:moxy/ui/screens/admin/pages/order_product_list/order_product_list.dart';

class OrderProductListScreen extends StatefulWidget {
  const OrderProductListScreen({super.key});

  @override
  OrderProductListScreenState createState() => OrderProductListScreenState();
}

class OrderProductListScreenState extends State<OrderProductListScreen> {
  late OrderProductListCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit =
        OrderProductListCubit(OrderProductListState.defaultAllProductsState());
    cubit.orderProductsList(); // Fetch data when the screen is opened
  }

  @override
  void dispose() {
    cubit.close(); // Close the cubit when it's no longer needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocConsumer<OrderProductListCubit, OrderProductListState>(
        listener: (context, state) {
          if (state.errorMessage != '') {
            ScaffoldMessenger.of(context).showSnackBar(
              snackBarWhenFailure(snackBarFailureText: 'Failed'),
            );
            // Handle any other error-related logic here
          }
        },
        builder: (context, state) {
          return OrderProductList(
            state: state,
            cubit: cubit,
          );
        },
      ),
    );
  }
}
