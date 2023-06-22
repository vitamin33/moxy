import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/theme/app_theme.dart';

import '../../../../../constant/image_path.dart';
import '../../../../../constant/order_constants.dart';
import '../../../../../domain/create_order/create_order_cubit.dart';
import '../../../../../domain/create_order/create_order_state.dart';
import '../../../../../domain/create_order/search_cities/search_cities_cubit.dart';
import '../../../../../domain/create_order/search_warehouse/search_warehouse_cubit.dart';
import '../../../../../domain/models/city.dart';
import '../../../../../domain/models/warehouse.dart';
import '../city_dropdown.dart';
import '../warehouse_dropdown.dart';

class Delivery extends StatelessWidget {
  const Delivery({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrderCubit, CreateOrderState>(
        //  BlocConsumer<CreateOrderCubit, CreateOrderState>(
        //     listener: (context, state) {
        //   if (state.selectedCity != null) {
        //     BlocProvider.of<SearchWarehouseCubit>(context).clearWarehouse();
        //   }
        // },
        builder: (context, state) {
      final cubit = context.read<CreateOrderCubit>();
      return MultiBlocProvider(
          providers: [
            BlocProvider<SearchCitiesCubit>(
              create: (BuildContext context) => SearchCitiesCubit(),
            ),
            BlocProvider<SearchWarehouseCubit>(
              create: (BuildContext context) => SearchWarehouseCubit(),
            ),
          ],
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
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
                              cubit.selectDeliveryType(DeliveryType.novaPost);
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 3,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: state.deliveryType ==
                                          DeliveryType.novaPost
                                      ? Colors.black
                                      : AppTheme.white,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
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
                              cubit.selectDeliveryType(DeliveryType.ukrPost);
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 3,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color:
                                      state.deliveryType == DeliveryType.ukrPost
                                          ? Colors.black
                                          : AppTheme.white,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
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
                ),
                state.deliveryType.index == 0
                    ? Padding(
                        padding: const EdgeInsets.all(AppTheme.cardPadding),
                        child: Column(
                          children: const [
                            SearchCityDropdown(),
                            SizedBox(height: 20),
                            SearchWarehouseDropdown(),
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          ));
    });
  }
}
