import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/profile/profile_cubit.dart';
import 'package:moxy/domain/models/order.dart';

import '../../../../../../domain/client/profile/profile_state.dart';
import '../../../../../theme/app_theme.dart';

class ProfileHistoryOrder extends StatelessWidget {
  const ProfileHistoryOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
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
                state.historyOrders.isEmpty
                    ? const Text('Order History Empty')
                    : SizedBox(
                        height: 250,
                        width: 400,
                        child: ListView.builder(
                          itemCount: state.historyOrders.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: AppTheme.greyLigth, width: 1)),
                                width: 200,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              state.historyOrders[index]
                                                  .orderedItems
                                                  .map((item) =>
                                                      item.productName)
                                                  .join(', '),
                                              style: const TextStyle(
                                                  color: AppTheme.gray,
                                                  fontSize: 17),
                                            ),
                                            Text(state
                                                .historyOrders[index]
                                                .orderedItems
                                                .first
                                                .productPrice),
                                            Text(
                                              state.historyOrders[index]
                                                  .createdAt,
                                              style: const TextStyle(
                                                  color: AppTheme.gray,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: _buildProductImage(state
                                                  .historyOrders[index]
                                                  .orderedItems
                                                  .first),
                                            )),
                                      ),
                                    ]),
                              ),
                            );
                          },
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildProductImage(OrderedItem product) {
  if (product.imageUrl != null) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/placeholder.jpg',
      image: product.imageUrl!,
      width: 70,
      fit: BoxFit.cover,
    );
  } else {
    return Image.asset(
      'assets/images/placeholder.jpg',
      width: 70,
      fit: BoxFit.cover,
    );
  }
}
