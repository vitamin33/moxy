import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/constant/order_status.dart';
import 'package:moxy/domain/client/profile/profile_cubit.dart';
import 'package:moxy/domain/models/order.dart';
import 'package:moxy/domain/models/status.dart';

import '../../../../../../domain/client/profile/profile_state.dart';
import '../../../../../theme/app_theme.dart';

class ProfileHistoryOrder extends StatelessWidget {
  const ProfileHistoryOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Історія Замовлення',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(child: _buildOrdersList(state)),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Widget _buildOrdersList(ProfileState state) {
    return state.historyOrders.isEmpty
        ? const Text('No Orders')
        : _listView(state);
  }

  Widget _listView(ProfileState state) {
    return ListView.builder(
      itemCount: state.historyOrders.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        Order order = state.historyOrders[index];
        OrderedItem first = order.orderedItems.first;
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.greyLigth, width: 1)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildProductImage(first),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                order.fullOrderName(),
                                style: const TextStyle(
                                    color: AppTheme.gray, fontSize: 17),
                              ),
                              Text('${order.totalValue()} UAH'),
                              Text(
                                state.historyOrders[index].createdAt,
                                style: const TextStyle(
                                    color: AppTheme.gray, fontSize: 10),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              order.status.statusTitle,
                              style: TextStyle(
                                  color: _statusColor(order.status),
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        );
      },
    );
  }

  Color _statusColor(Status status) {
    switch (status.statusValue) {
      case OrderStatus.Canceled:
      case OrderStatus.PaymentFailed:
      case OrderStatus.Returned:
        return AppTheme.red;
      case OrderStatus.Sent:
      case OrderStatus.Sale:
      case OrderStatus.Paid:
        return AppTheme.greenDark;
      default:
        return AppTheme.gray;
    }
  }
}

Widget _buildProductImage(OrderedItem product) {
  final image = product.dimensions.first.images.first.imagePath;
  return FadeInImage.assetNetwork(
    placeholder: 'assets/images/placeholder.jpg',
    image: image,
    height: 70,
    width: 70,
    fit: BoxFit.cover,
  );
}
