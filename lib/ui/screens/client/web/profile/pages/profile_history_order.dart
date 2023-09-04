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
        return Container(
          width: double.infinity,
          height: 100,
          padding: const EdgeInsets.all(AppTheme.cardPadding),
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
             const SizedBox(height: 20),
              state.profile.orders.isEmpty
                  ? const Text('Order History Empty')
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            color: AppTheme.white,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(state.profile.orders[index]
                                        .orderedItems.first.productName),
                                    Text(state.profile.orders[index].client
                                        .firstName),
                                   
                                  ]),
                            ),
                          ),
                        );
                      },
                    )
            ],
          ),
        );
      },
    );
  }
}
