import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/constant/place_production.dart';
import 'package:moxy/domain/admin/create_product/create_product_cubit.dart';
import 'package:moxy/domain/admin/create_product/create_product_state.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class PlaceProductionConrainer extends StatelessWidget {
  const PlaceProductionConrainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        final cubit = context.read<CreateProductCubit>();
        final theme = AppTheme.of(context)!;
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Place Production:',
                style: theme.titleText,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Radio(
                          value: PlaceProduction.china,
                          groupValue: state.placeProduction,
                          onChanged: (onChange) {
                            cubit.changePlaceProduction(PlaceProduction.china);
                          }),
                      const Text('Kитай')
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      Radio(
                          value: PlaceProduction.ukraine,
                          groupValue: state.placeProduction,
                          onChanged: (onChange) {
                            cubit
                                .changePlaceProduction(PlaceProduction.ukraine);
                          }),
                      const Text('Украіна')
                    ],
                  ),
                ],
              )
            ]);
      },
    );
  }
}
