import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/profile/profile_cubit.dart';

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
          height: 100,
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
                const SizedBox(height: 40),
                state.profile.orders.isEmpty
                    ? const Text('Order History Empty')
                    : SizedBox(
                        height: 200,
                        width: 200,
                        child: ListView.builder(
                          itemCount: state.profile.orders.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: 100,
                                height: 100,
                                color: AppTheme.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(state.profile.orders[index].status
                                            .statusTitle),
                                        Text(state.profile.orders[index]
                                            .paymentType.name),
                                        // Text(state.profile.orders[index].orderedItems.first.imageUrl!
                                        // ),
                                        // Text(state.profile.orders[index].client
                                        //     .firstName),
                                      ]),
                                ),
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
