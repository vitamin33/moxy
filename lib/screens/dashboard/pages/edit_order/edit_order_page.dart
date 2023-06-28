import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/components/custom_button.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/edit_order/edit_order_cubit.dart';
import 'package:moxy/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';
import '../../../../../constant/order_status.dart';

import '../../../../constant/image_path.dart';
import '../../../../constant/order_constants.dart';
import '../../../../domain/create_order/search_cities/search_cities_cubit.dart';
import '../../../../domain/create_order/search_warehouse/search_warehouse_cubit.dart';
import '../../../../domain/edit_order/edit_order_state.dart';
import '../../../../navigation/home_router_cubit.dart';
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
        return MultiBlocProvider(
            providers: [
              BlocProvider<SearchCitiesCubit>(
                create: (BuildContext context) => SearchCitiesCubit(),
              ),
              BlocProvider<SearchWarehouseCubit>(
                create: (BuildContext context) => SearchWarehouseCubit(),
              ),
            ],
            child: Scaffold(
                body: Material(
                    color: AppTheme.white,
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.cardPadding),
                      child: SingleChildScrollView(
                        child: Column(children: [
                          contactDetails(context, state, cubit),
                          const SizedBox(height: 20),
                          typePayment(state, cubit),
                          const SizedBox(height: 20),
                          typeDelivery(state, cubit),
                          const SizedBox(height: 20),
                          dataRange(),
                          const SizedBox(height: 20),
                          orderStatus(context, state, cubit),
                          const SizedBox(height: 20),
                          CustomButton(
                            title: 'Edit',
                            onTap: () {
                              cubit.editOrder();
                            },
                            buttonWidth: MediaQuery.of(context).size.width,
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
                        '${state.client.firstName}  ${state.client.secondName}'),
                    TextButton(
                        onPressed: () {
                          cubit.changeEditName();
                        },
                        child: const Text('Change'))
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
                Text(state.client.mobileNumber),
                TextButton(
                    onPressed: () {
                      cubit.changeEditPhone();
                    },
                    child: const Text('Change'))
              ]),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SvgPicture.asset(IconPath.selectedProduct),
          Text(state.selectedProducts.first.productName),
          TextButton(
              onPressed: () {
                context.read<HomeRouterCubit>().navigateTo(
                      const OrderProductListPageState(),
                    );
              },
              child: const Text('Change'))
        ]),
      )
    ],
  );
}

Widget typePayment(EditOrderState state, EditOrderCubit cubit) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text('Type Payment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          InkWell(
            onTap: () {
              cubit.changePayment(PaymentType.fullPayment);
            },
            child: CircleAvatar(
              radius: 30,
              backgroundColor: state.paymentType == PaymentType.fullPayment
                  ? AppTheme.black
                  : AppTheme.white,
              child: CircleAvatar(
                radius: 28,
                backgroundColor: AppTheme.white,
                child: SvgPicture.asset(IconPath.fullPayment, width: 30),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              cubit.changePayment(PaymentType.cashAdvance);
            },
            child: CircleAvatar(
              radius: 30,
              backgroundColor: state.paymentType == PaymentType.cashAdvance
                  ? AppTheme.black
                  : AppTheme.white,
              child: CircleAvatar(
                radius: 28,
                backgroundColor: AppTheme.white,
                child: SvgPicture.asset(
                  IconPath.cashPayment,
                  width: 30,
                ),
              ),
            ),
          )
        ],
      ),
      state.paymentType == PaymentType.cashAdvance
          ? Container(
              width: 150,
              height: 50,
              child: TextField(
                controller: cubit.paymentController,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
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
                      width: 3,
                      color: state.deliveryType == DeliveryType.novaPost
                          ? AppTheme.pink
                          : AppTheme.white),
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
                      width: 3,
                      color: state.deliveryType == DeliveryType.ukrPost
                          ? AppTheme.pink
                          : AppTheme.white),
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
                  SearchCityDropdown(
                      selectedCity: state.selectedCity,
                      selectedWarehouse: state.selectedWarehouse,
                      onChanged: (city) {
                        cubit.selectCity(city);
                      }),
                  // SearchCityDropdown(),
                  const SizedBox(height: 20),
                  SearchWarehouseDropdown(
                      selectedCity: state.selectedCity,
                      selectedWarehouse: state.selectedWarehouse,
                      onChanged: (warehouse) {
                        cubit.selectWarehouse(warehouse);
                      })
                  // SearchWarehouseDropdown(),
                ],
              ),
            )
          : Container()
    ],
  );
}

Widget dataRange() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: const [
      Text('Date Range',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      SizedBox(
          width: 200,
          height: 40,
          child: TextField(
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
                      child: InkWell(
                        onTap: () {
                          cubit.changeStatus(status.statusTitle);
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              isSelected ? AppTheme.black : AppTheme.white,
                          child: InkWell(
                            child: CircleAvatar(
                              radius: 28,
                              backgroundColor: AppTheme.white,
                              child:
                                  SvgPicture.asset(status.iconPath, width: 30),
                            ),
                          ),
                        ),
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
