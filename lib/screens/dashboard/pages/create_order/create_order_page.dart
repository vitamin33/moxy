import 'package:bloc_effects/bloc_effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/models/order.dart';
import 'package:moxy/screens/dashboard/pages/create_order/pages/about.dart';
import 'package:moxy/screens/dashboard/pages/create_order/pages/delivery.dart';
import 'package:moxy/screens/dashboard/pages/create_order/pages/payment.dart';
import 'package:moxy/screens/dashboard/pages/create_order/pages/status.dart';

import '../../../../components/app_indicator.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/loader.dart';
import '../../../../components/snackbar_widgets.dart';
import '../../../../components/succes_card.dart';
import '../../../../domain/create_order/create_order_cubit.dart';
import '../../../../domain/create_order/create_order_effects.dart';
import '../../../../domain/create_order/create_order_state.dart';
import '../../../../domain/models/product.dart';
import '../../../../domain/ui_effect.dart';
import '../../../../theme/app_theme.dart';

class CreateOrderPage extends StatelessWidget {
  CreateOrderPage();

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = const [About(), Payment(), Delivery(), Status()];

    return BlocProvider<CreateOrderCubit>(
      create: (BuildContext context) => CreateOrderCubit(CreateOrderState(
          isLoading: false,
          isSuccess: false,
          errorMessage: '',
          initialPage: 0,
          activePage: 0,
          errors: FieldErrors(),
          deliveryType: '',
          paymentType: '',
          novaPostNumber: 0,
          products: [Product.defaultProduct()],
          client:Client.defaultClient()
          )),
      child: BlocEffectListener<CreateOrderCubit, UiEffect, CreateOrderState>(
        listener: (context, effect, state) {
          if (effect is ValidationFailed) {
            ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
                snackBarFailureText: 'Wrong input, please check text fields.'));
          }
        },
        child: BlocConsumer<CreateOrderCubit, CreateOrderState>(
          listener: (context, state) => {
            if (state.errorMessage != '')
              {
                ScaffoldMessenger.of(context).showSnackBar(
                    snackBarWhenFailure(snackBarFailureText: 'Failed')),
                context.read<CreateOrderCubit>().clearErrorState(),
              }
          },
          builder: (context, state) {
            final cubit = context.read<CreateOrderCubit>();
            return Material(
              color: AppTheme.pink,
              child:
                  //  state.isSuccess
                  //     ? succsess(
                  //         onTap:
                  //             state.isEdit ? cubit.backToProduct : cubit.createNew,
                  //         title: 'Product Added',
                  //         titleButton:
                  //             state.isEdit ? 'Back To Product' : 'Create New')
                  //     :
                  state.isLoading
                      ? loader()
                      : Stack(
                          children: [
                            Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 550,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: AppIndicator(
                                                activePage: state.activePage,
                                                inadicatorName: const [
                                                  'About',
                                                  'Payment',
                                                  'Delivery',
                                                  'Status'
                                                ],
                                                pages: const [
                                                  About(),
                                                  Payment(),
                                                  Delivery(),
                                                  Status()
                                                ],
                                                controller:
                                                    cubit.pageController),
                                          ),
                                          const SizedBox(height: 30),
                                          Expanded(
                                            child: PageView.builder(
                                              controller: cubit.pageController,
                                              onPageChanged: (int page) {
                                                cubit.onChangePage(page);
                                              },
                                              itemCount: pages.length,
                                              itemBuilder: (context, index) {
                                                return pages[
                                                    index % pages.length];
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            positionButton(state, cubit)
                          ],
                        ),
            );
          },
        ),
      ),
    );
  }
}

Widget positionButton(CreateOrderState state, CreateOrderCubit cubit) {
  return Positioned(
    height: 60,
    bottom: 40,
    left: 0,
    right: 0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        state.activePage != 0
            ? CutomButton(
                title: 'Previus',
                onTap: cubit.moveToPreviustPage,
                buttonWidth: 150,
                outline: true,
              )
            : Container(
                width: 150,
              ),
        CutomButton(
          title: state.activePage != 3 ? 'Next' : 'Add',
          onTap: cubit.moveToNextPage,
          buttonWidth: 150,
        )
      ],
    ),
  );
}
