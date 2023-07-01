import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/admin/edit_order/edit_order_cubit.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/theme/app_theme.dart';

import '../../../../../../constant/order_status.dart';
import '../../../../../constant/image_path.dart';
import '../../../../../constant/order_constants.dart';
import '../../../../../domain/admin/create_order/search_cities/search_cities_cubit.dart';
import '../../../../../domain/admin/create_order/search_warehouse/search_warehouse_cubit.dart';
import '../../../../../domain/admin/edit_order/edit_order_state.dart';
import '../../../../../services/navigation/admin_home_router_cubit.dart';
import '../../../../components/loader.dart';
import '../../../../components/succes_card.dart';
import '../create_order/city_dropdown.dart';
import '../create_order/warehouse_dropdown.dart';

class EditOrderPage extends StatelessWidget {
  const EditOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditOrderCubit, EditOrderState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<EditOrderCubit>();
        return state.isSuccess
            ? succsess(
                onTap: () {
                  context.read<AdminHomeRouterCubit>().navigateTo(
                        const OrdersPageState(),
                      );
                  cubit.clearState();
                },
                title: 'Order Edited',
                titleButton: 'Back To Order')
            : state.isLoading
                ? loader()
                : MultiBlocProvider(
                    providers: [
                        BlocProvider<SearchCitiesCubit>(
                          create: (BuildContext context) => SearchCitiesCubit(),
                        ),
                        BlocProvider<SearchWarehouseCubit>(
                          create: (BuildContext context) =>
                              SearchWarehouseCubit(),
                        ),
                      ],
                    child: Scaffold(
                        body: Material(
                            color: AppTheme.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(AppTheme.cardPadding),
                              child: SingleChildScrollView(
                                child: Column(children: [
                                  contactDetails(context, state, cubit),
                                  const SizedBox(height: 20),
                                  typePayment(state, cubit),
                                  const SizedBox(height: 20),
                                  typeDelivery(state, cubit),
                                  const SizedBox(height: 20),
                                  dataRange(cubit),
                                  const SizedBox(height: 20),
                                  orderStatus(context, state, cubit),
                                  const SizedBox(height: 20),
                                  CustomButton(
                                    title: 'Edit',
                                    onTap: () {
                                      cubit.editOrder();
                                    },
                                    buttonWidth:
                                        MediaQuery.of(context).size.width,
                                  )
                                ]),
                              ),
                            ))));
      },
    );
  }
}

Widget contactDetails(
  BuildContext context,
  EditOrderState state,
  EditOrderCubit cubit,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Contact Details',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 10),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: state.isEditName
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      IconPath.personName,
                    ),
                    SizedBox(
                        width: 130,
                        height: 50,
                        child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                          controller: cubit.nameEditController,
                        )),
                    IconButton(
                        onPressed: () {
                          cubit.addEditName();
                        },
                        icon: const Icon(Icons.check))
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      IconPath.personName,
                    ),
                    Text(
                        '${state.client.firstName}  ${state.client.secondName}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.gray,
                        )),
                    TextButton(
                        onPressed: () {
                          cubit.changeEditName();
                        },
                        child: const Text(
                          'Change',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.pinkDark,
                          ),
                        ))
                  ],
                )),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: state.isEditPhone
            ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SvgPicture.asset(IconPath.phone),
                SizedBox(
                    width: 130,
                    height: 50,
                    child: TextField(
                      controller: cubit.phoneEditController,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    )),
                IconButton(
                    onPressed: () {
                      cubit.addEditPhone();
                    },
                    icon: const Icon(Icons.check))
              ])
            : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SvgPicture.asset(IconPath.phone),
                Text(state.client.mobileNumber,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.gray,
                    )),
                TextButton(
                    onPressed: () {
                      cubit.changeEditPhone();
                    },
                    child: const Text(
                      'Change',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.pinkDark,
                      ),
                    ))
              ]),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SvgPicture.asset(IconPath.selectedProduct),
          Text(state.selectedProducts.first.productName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.gray,
              )),
          TextButton(
              onPressed: () {
                context.read<AdminHomeRouterCubit>().navigateTo(
                      const OrderProductListPageState(),
                    );
              },
              child: const Text(
                'Change',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.pinkDark,
                ),
              ))
        ]),
      )
    ],
  );
}

Widget typePayment(EditOrderState state, EditOrderCubit cubit) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Type Payment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      cubit.changePayment(PaymentType.fullPayment);
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor:
                          state.paymentType == PaymentType.fullPayment
                              ? AppTheme.pinkDark
                              : AppTheme.greyLigth,
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: AppTheme.white,
                        child:
                            SvgPicture.asset(IconPath.fullPayment, width: 30),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'Full payment',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      cubit.changePayment(PaymentType.cashAdvance);
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor:
                          state.paymentType == PaymentType.cashAdvance
                              ? AppTheme.pinkDark
                              : AppTheme.greyLigth,
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: AppTheme.white,
                        child: SvgPicture.asset(
                          IconPath.cashPayment,
                          width: 30,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text('Cash Advance',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  )
                ],
              )
            ],
          )
        ],
      ),
      state.paymentType == PaymentType.cashAdvance
          ? Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: TextField(
                    controller: cubit.paymentController,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
              ],
            )
          : Container()
    ],
  );
}

Widget typeDelivery(EditOrderState state, EditOrderCubit cubit) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text('Type Delivery',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
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
                  borderRadius: const BorderRadius.all(Radius.circular(6))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(ImageAssets.novaPoshta),
              ),
            ),
          ),
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
                  borderRadius: const BorderRadius.all(Radius.circular(6))),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(ImageAssets.ukrPoshta),
              ),
            ),
          )
        ],
      ),
      state.deliveryType == DeliveryType.novaPost
          ? Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SearchCityDropdown(
                      selectedCity: state.selectedCity,
                      selectedWarehouse: state.selectedWarehouse,
                      onChanged: (city) {
                        cubit.selectCity(city);
                      }),
                  const SizedBox(height: 20),
                  SearchWarehouseDropdown(
                      selectedCity: state.selectedCity,
                      selectedWarehouse: state.selectedWarehouse,
                      onChanged: (warehouse) {
                        cubit.selectWarehouse(warehouse);
                      })
                ],
              ),
            )
          : Container()
    ],
  );
}

Widget dataRange(EditOrderCubit cubit) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text('Date Range',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      SizedBox(
          width: 200,
          height: 40,
          child: TextField(
            controller: cubit.dateController,
            decoration: InputDecoration(border: OutlineInputBorder()),
          )),
    ],
  );
}

Widget orderStatus(context, EditOrderState state, cubit) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Order Status',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
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
                  final status = allStatusOrder[index];
                  final isSelected = status.statusTitle == state.status;
                  return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          InkWell(
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500)),
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
