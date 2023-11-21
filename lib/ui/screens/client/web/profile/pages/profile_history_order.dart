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
    final theme = AppTheme.of(context)!;
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
                  Text('Історія Замовлення', style: theme.headline3BoltText),
                  const SizedBox(height: 10),
                  Expanded(child: _buildOrdersList(state, theme)),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Widget _buildOrdersList(ProfileState state, AppTheme theme) {
    return state.historyOrders.isEmpty
        ? const Text('No Orders')
        : _listView(state, theme);
  }

  Widget _listView(ProfileState state, AppTheme theme) {
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
                                style: theme.titleText
                                    .copyWith(color: AppTheme.gray),
                              ),
                              Text('${order.totalValue()} UAH'),
                              Text(
                                state.historyOrders[index].createdAt,
                                style: theme.smallText
                                    .copyWith(color: AppTheme.gray),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              order.status.statusTitle,
                              style: theme.headlineText
                                  .copyWith(color: _statusColor(order.status)),
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
