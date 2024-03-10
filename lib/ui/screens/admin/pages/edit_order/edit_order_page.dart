import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:moxy/domain/admin/all_orders/all_orders_cubit.dart';
import 'package:moxy/domain/admin/edit_order/edit_order_cubit.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/components/custom_textfield.dart';
import 'package:moxy/ui/screens/admin/pages/edit_order/contact_details.dart';
import 'package:moxy/ui/screens/admin/pages/edit_order/type_payment.dart';
import 'package:moxy/ui/theme/app_theme.dart';

import '../../../../../../constant/order_status.dart';
import '../../../../../constant/image_path.dart';
import '../../../../../constant/order_constants.dart';
import '../../../../../domain/admin/create_order/search_cities/search_cities_cubit.dart';
import '../../../../../domain/admin/create_order/search_warehouse/search_warehouse_cubit.dart';
import '../../../../../domain/admin/edit_order/edit_order_state.dart';
import '../../../../components/loader.dart';
import '../../../../components/succes_card.dart';
import '../create_order/bottom_sheet_city_dropdown.dart';
import '../create_order/bottom_sheet_warehouse_dropdown.dart';
import '../create_product/create_product_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class EditOrderPage extends StatelessWidget {
  String? orderId;
  EditOrderPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;

    return BlocConsumer<EditOrderCubit, EditOrderState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<EditOrderCubit>();
        return MultiBlocProvider(
          providers: [
            BlocProvider<SearchCitiesCubit>(
              create: (BuildContext context) => SearchCitiesCubit(
                selectedCity: cubit.state.selectedCity,
              ),
            ),
            BlocProvider<SearchWarehouseCubit>(
              create: (BuildContext context) => SearchWarehouseCubit(
                selectedWarehouse: cubit.state.selectedWarehouse,
              ),
            ),
          ],
          child: Material(
            color: AppTheme.white,
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return KeyboardVisibilityBuilder(
                builder: (context, isKeyboardVisible) {
                  return state.isSuccess
                      ? SuccessCard(
                          onTap: () {
                            context.pop();
                            cubit.clearState();
                            context.read<AllOrdersCubit>().refreshOrderList();
                          },
                          title: AppLocalizations.of(context)!.orderEdited,
                          titleButton:
                              AppLocalizations.of(context)!.backToOrder)
                      : state.isLoading
                          ? loader()
                          : Column(
                              children: [
                                SizedBox(
                                  height: isKeyboardVisible
                                      ? constraints.maxHeight
                                      : constraints.maxHeight -
                                          bottomButtonsHeight,
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Column(
                                        children: [
                                          dataRange(state, context, theme),
                                          const SizedBox(height: 10),
                                          ContactDetails(state: state),
                                          const SizedBox(height: 20),
                                          TypePayment(state: state),
                                          const SizedBox(height: 20),
                                          typeDelivery(
                                              state, cubit, context, theme),
                                          const SizedBox(height: 20),
                                          orderStatus(
                                              context, state, cubit, theme),
                                          const SizedBox(height: 20),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                !state.isSuccess
                                    ? positionEditOrderButton(state, cubit,
                                        isKeyboardVisible, context)
                                    : Container(),
                              ],
                            );
                },
              );
            }),
          ),
        );
      },
    );
  }
}

Widget typeDelivery(
    EditOrderState state, EditOrderCubit cubit, context, AppTheme theme) {
  return Column(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context)!.filterTypeDelivery,
                style: theme.largeBoltText),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    cubit.changeDelivery(DeliveryType.novaPost);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: state.deliveryType == DeliveryType.novaPost
                                ? AppTheme.pinkDark
                                : AppTheme.greyLigth),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        width: 60,
                        height: 30,
                        ImageAssets.novaPoshta,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 28),
                InkWell(
                  onTap: () {
                    cubit.changeDelivery(DeliveryType.ukrPost);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: state.deliveryType == DeliveryType.ukrPost
                                ? AppTheme.pinkDark
                                : AppTheme.greyLigth),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        width: 60,
                        height: 30,
                        ImageAssets.ukrPoshta,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        child: Container(
          child: state.deliveryType == DeliveryType.novaPost
              ? Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    BottomSearchCityDropdown(
                        selectedCity: state.selectedCity,
                        selectedWarehouse: state.selectedWarehouse,
                        onChanged: (city) {
                          cubit.selectCity(city);
                        }),
                    const SizedBox(height: 20),
                    BottomSearchWarehouseDropdown(
                        selectedCity: state.selectedCity,
                        selectedWarehouse: state.selectedWarehouse,
                        onChanged: (warehouse) {
                          cubit.selectWarehouse(warehouse);
                        })
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: CustomTextField(
                    title: AppLocalizations.of(context)!.novaPostDelivery,
                    maxLines: 4,
                    controller: cubit.ukrPostInfoController,
                    onChanged: cubit.ukrPostInfoChanged,
                    validation: true,
                    state: state.errors.ukrPostInfo,
                  ),
                ),
        ),
      ),
    ],
  );
}

Widget dataRange(EditOrderState state, BuildContext context, AppTheme theme) {
  return SizedBox(
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(AppLocalizations.of(context)!.creationDate,
            style: theme.largeBoltText),
        Text(state.createdAt,
            style: theme.largeSemiBoltText.copyWith(color: AppTheme.gray)),
      ],
    ),
  );
}

Widget orderStatus(BuildContext context, EditOrderState state,
    EditOrderCubit cubit, AppTheme theme) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(AppLocalizations.of(context)!.filterOrderStatus,
          style: theme.largeBoltText),
      const SizedBox(height: 5),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: allStatusOrder.length,
                itemBuilder: (context, index) {
                  final allStatusOrder = getAllStatusOrder(context);
                  final status = allStatusOrder[index];
                  final isSelected = status.statusTitle == state.status;
                  return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          InkWell(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            onTap: () {
                              cubit.changeStatus(status.statusTitle);
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: isSelected
                                  ? AppTheme.pinkDark
                                  : AppTheme.greyLigth,
                              child: InkWell(
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundColor: AppTheme.white,
                                  child: SvgPicture.asset(status.iconPath,
                                      width: 30),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(status.statusTitle,
                                style: theme.mediumBoltText),
                          )
                        ],
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget positionEditOrderButton(EditOrderState state, EditOrderCubit cubit,
    bool isKeyboardVisible, context) {
  double buttonsHeight = isKeyboardVisible ? 0 : 70;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: SizedBox(
        height: buttonsHeight,
        child: OutlineStateButton(
          title: 'Edit',
          onTap: () {
            cubit.editOrder();
          },
          buttonWidth: MediaQuery.of(context).size.width,
        )),
  );
}
