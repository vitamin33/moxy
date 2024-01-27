import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/models/city.dart';
import 'package:moxy/domain/models/warehouse.dart';
import 'package:moxy/ui/components/custom_textfield.dart';
import 'package:moxy/ui/theme/app_theme.dart';

import '../../../../../../constant/image_path.dart';
import '../../../../../../constant/order_constants.dart';
import '../../../../../../domain/admin/create_order/create_order_cubit.dart';
import '../../../../../../domain/admin/create_order/create_order_state.dart';
import '../../../../../../domain/admin/create_order/search_cities/search_cities_cubit.dart';
import '../../../../../../domain/admin/create_order/search_warehouse/search_warehouse_cubit.dart';
import '../bottom_sheet_city_dropdown.dart';
import '../bottom_sheet_warehouse_dropdown.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Delivery extends StatelessWidget {
  const Delivery({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrderCubit, CreateOrderState>(
        builder: (context, state) {
      final cubit = context.read<CreateOrderCubit>();
      return MultiBlocProvider(
          providers: [
            BlocProvider<SearchCitiesCubit>(
              create: (BuildContext context) =>
                  SearchCitiesCubit(selectedCity: cubit.state.selectedCity),
            ),
            BlocProvider<SearchWarehouseCubit>(
              create: (BuildContext context) => SearchWarehouseCubit(
                selectedWarehouse: cubit.state.selectedWarehouse,
              ),
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
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  child: Container(
                    child: state.deliveryType == DeliveryType.novaPost
                        ? _buildNovaPostArea(cubit, state)
                        : _buildUkrPostArea(context, cubit, state),
                  ),
                ),
              ],
            ),
          ));
    });
  }

  Widget _buildNovaPostArea(CreateOrderCubit cubit, CreateOrderState state) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.cardPadding),
      child: Column(
        key: UniqueKey(),
        children: [
          BottomSearchCityDropdown(
            selectedCity: state.selectedCity ?? City.defaultCity(),
            selectedWarehouse: state.selectedWarehouse,
            onChanged: (city) {
              cubit.selectCity(city);
            },
          ),
          const SizedBox(height: 20),
          BottomSearchWarehouseDropdown(
            selectedCity: state.selectedCity ?? City.defaultCity(),
            selectedWarehouse:
                state.selectedWarehouse ?? Warehouse.defaultWarehouse(),
            onChanged: (warehouse) {
              cubit.selectWarehouse(warehouse);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUkrPostArea(
      BuildContext context, CreateOrderCubit cubit, CreateOrderState state) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.cardPadding),
      child: CustomTextField(
        key: UniqueKey(),
        title: AppLocalizations.of(context)!.novaPostDelivery,
        maxLines: 4,
        controller: cubit.ukrPostInfoController,
        onChanged: cubit.ukrPostInfoChanged,
        validation: true,
        state: state.errors.ukrPostInfo,
      ),
    );
  }
}
