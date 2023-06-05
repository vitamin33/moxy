import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/theme/app_theme.dart';

import '../../../../../constant/image_path.dart';
import '../../../../../domain/create_order/create_order_cubit.dart';
import '../../../../../domain/create_order/create_order_state.dart';

class Delivery extends StatelessWidget {
  const Delivery({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrderCubit, CreateOrderState>(
        builder: (context, state) {
      final cubit = context.read<CreateOrderCubit>();
      return Padding(
        padding: const EdgeInsets.all(AppTheme.cardPadding),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    cubit.selectDeliveryType('Nova Poshta');
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: state.deliveryType == 'Nova Poshta'
                            ? Colors.black
                            : AppTheme.white,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: AppTheme.white,
                    ),
                    child: Center(
                      child: Image.asset(ImageAssets.novaPoshta),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: () {
                    cubit.selectDeliveryType('Ukr Poshta');
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: state.deliveryType == 'Ukr Poshta'
                            ? Colors.black
                            : AppTheme.white,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: AppTheme.white,
                    ),
                    child: Center(
                      child: Image.asset(ImageAssets.ukrPoshta),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
