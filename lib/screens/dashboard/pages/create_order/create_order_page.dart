import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:moxy/screens/dashboard/pages/create_order/pages/about.dart';
import 'package:moxy/screens/dashboard/pages/create_order/pages/delivery.dart';
import 'package:moxy/screens/dashboard/pages/create_order/pages/payment.dart';
import 'package:moxy/screens/dashboard/pages/create_order/pages/status_page.dart';

import '../../../../components/app_indicator.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/loader.dart';
import '../../../../components/snackbar_widgets.dart';
import '../../../../components/succes_card.dart';
import '../../../../domain/create_order/create_order_cubit.dart';
import '../../../../domain/create_order/create_order_effects.dart';
import '../../../../domain/create_order/create_order_state.dart';
import '../../../../navigation/home_router_cubit.dart';
import '../../../../theme/app_theme.dart';
import '../create_product/create_product_page.dart';

// ignore: must_be_immutable
class CreateOrderPage extends StatelessWidget {

 const CreateOrderPage() ;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = const [About(), Payment(), Delivery(), StatusPage()];
    final CreateOrderCubit cubit = context.read<CreateOrderCubit>();
    cubit.effectStream.listen((effect) {
      if (effect is ValidationFailed) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
            snackBarFailureText: 'Wrong input, please check text fields.'));
      }
    });

    return BlocConsumer<CreateOrderCubit, CreateOrderState>(
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
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return KeyboardVisibilityBuilder(
                builder: (context, isKeyboardVisible) {
              return state.isSuccess
                  ? succsess(
                      onTap: () {
                        if (state.isEdit) {
                          cubit.createNew();
                        } else {
                          cubit.clearState();
                          context.read<HomeRouterCubit>().navigateTo(
                                const OrdersPageState(),
                              );
                        }
                      },
                      title: 'Order Added',
                      titleButton:
                          state.isEdit ? 'Create New' : 'Back To Product')
                  : state.isLoading
                      ? loader()
                      : Column(
                          children: [
                            SingleChildScrollView(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: isKeyboardVisible
                                    ? constraints.maxHeight
                                    : constraints.maxHeight -
                                        bottomButtonsHeight,
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
                                            StatusPage()
                                          ],
                                          controller: cubit.pageController),
                                    ),
                                    Expanded(
                                      child: PageView.builder(
                                        controller: cubit.pageController,
                                        onPageChanged: (int page) {
                                          cubit.onChangePage(page);
                                        },
                                        itemCount: pages.length,
                                        itemBuilder: (context, index) {
                                          return pages[index % pages.length];
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            positionOrderButton(state, cubit, isKeyboardVisible)
                          ],
                        );
            });
          }),
        );
      },
    );
  }
}

Widget positionOrderButton(
    CreateOrderState state, CreateOrderCubit cubit, bool isKeyboardVisible) {
  double buttonsHeight = isKeyboardVisible ? 0 : bottomButtonsHeight;
  return SizedBox(
      height: buttonsHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          state.activePage != 0
              ? CustomButton(
                  title: 'Previus',
                  onTap: cubit.moveToPreviustPage,
                  buttonWidth: 150,
                  outline: true,
                )
              : Container(
                  width: 150,
                ),
          CustomButton(
            title: state.activePage != 3 ? 'Next' : 'Add',
            onTap: cubit.moveToNextPage,
            buttonWidth: 150,
          )
        ],
      ));
}
