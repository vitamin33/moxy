import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/services/navigation/admin_home_router_cubit.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/theme/app_theme.dart';

import '../../../../../../constant/order_status.dart';
import '../../../../../constant/image_path.dart';
import '../../../../../constant/order_constants.dart';
import '../../../../../domain/admin/filter_orders/filter_orders_cubit.dart';
import '../../../../../domain/admin/filter_orders/filter_orders_state.dart';
import '../../../../components/loader.dart';

class FilterOrderPage extends StatefulWidget {
  const FilterOrderPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _FilterOrderPageState createState() => _FilterOrderPageState();
}

class _FilterOrderPageState extends State<FilterOrderPage> {
  late final FilterOrdersCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<FilterOrdersCubit>();
    cubit.loadFilterParams();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterOrdersCubit, FilterOrdersState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state.isLoading
            ? loader()
            : Scaffold(
                body: Material(
                  color: AppTheme.white,
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.cardPadding),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        typePayment(state, cubit),
                        const SizedBox(height: 20),
                        typeDelivery(state, cubit),
                        const SizedBox(height: 20),
                        dataRange(cubit, context),
                        const SizedBox(height: 20),
                        orderStatus(context, state, cubit),
                        const SizedBox(height: 20),
                        CustomButton(
                          title: 'Show Results',
                          onTap: () {
                            cubit.saveFilterParams();
                            context.read<AdminHomeRouterCubit>().navigateTo(
                                  const OrdersPageState(),
                                );
                          },
                          buttonWidth: MediaQuery.of(context).size.width,
                        )
                      ]),
                    ),
                  ),
                ),
              );
      },
    );
  }
}

Widget typePayment(FilterOrdersState state, FilterOrdersCubit cubit) {
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
                      cubit.changePayment(FilterPaymentType.fullPayment);
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor:
                          state.paymentType == FilterPaymentType.fullPayment
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
                      cubit.changePayment(FilterPaymentType.cashAdvance);
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor:
                          state.paymentType == FilterPaymentType.cashAdvance
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
    ],
  );
}

Widget typeDelivery(FilterOrdersState state, FilterOrdersCubit cubit) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text('Type Delivery',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          InkWell(
            onTap: () {
              cubit.changeDelivery(FilterDeliveryType.novaPost);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 2,
                      color: state.deliveryType == FilterDeliveryType.novaPost
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
              cubit.changeDelivery(FilterDeliveryType.ukrPost);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 2,
                      color: state.deliveryType == FilterDeliveryType.ukrPost
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
    ],
  );
}

Widget dataRange(FilterOrdersCubit cubit, context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text('Date Range',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      SizedBox(
          width: 200,
          height: 50,
          child: TextField(
            controller: cubit.dateController,
            readOnly: true,
            onTap: () {
              cubit.selectDate(context);
            },
            decoration: const InputDecoration(border: OutlineInputBorder()),
          )),
    ],
  );
}

Widget orderStatus(context, FilterOrdersState state, cubit) {
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
