import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/admin/edit_order/edit_order_cubit.dart';
import 'package:moxy/domain/models/order.dart';

import '../../../../../services/navigation/admin_home_router_cubit.dart';
import '../../../../components/search_textfield.dart';
import '../../../../components/snackbar_widgets.dart';
import '../../../../../domain/admin/all_orders/all_orders_cubit.dart';
import '../../../../../domain/admin/all_orders/all_orders_state.dart';
import '../../../../theme/app_theme.dart';

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
          body: Material(
        color: AppTheme.pink,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SearchTextfield(
                title: 'Search',
              ),
            ),
            Expanded(
              child: state.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: state.allOrders.isEmpty
                          ? const Text('No orders')
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.allOrders.length,
                              itemBuilder: (BuildContext context, int index) {
                                final order = state.allOrders[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: const EdgeInsets.all(14.0),
                                    onTap: () {
                                      context
                                          .read<AdminHomeRouterCubit>()
                                          .navigateTo(
                                              const EditOrderPageState());
                                      context
                                          .read<EditOrderCubit>()
                                          .getOrder(order);
                                    },
                                    tileColor: AppTheme.white,
                                    leading: ClipOval(
                                        child: _buildImage(order.orderedItems)),
                                    title: Text(
                                        '${order.client.firstName} ${order.client.secondName}'),
                                    subtitle: Text(
                                        order.orderedItems.first.productName),
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                  ),
                                );
                              }),
                    ),
            ),
          ],
        ),
      ));
    });
  }

  Widget _buildImage(List<OrderedItem> products) {
    if (products.isEmpty || products.first.imageUrl == null) {
      return Image.asset(
        width: 50,
        height: 50,
        'assets/images/placeholder.jpg',
        fit: BoxFit.cover,
      );
    } else {
      return FadeInImage.assetNetwork(
        placeholder: 'assets/images/placeholder.jpg',
        image: products.first.imageUrl!,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    }
  }
}
