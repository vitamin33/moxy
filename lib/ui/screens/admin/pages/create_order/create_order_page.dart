import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:moxy/services/navigation/admin/admin_home_router_cubit.dart';
import 'package:moxy/ui/screens/admin/pages/create_order/pages/about.dart';
import 'package:moxy/ui/screens/admin/pages/create_order/pages/delivery.dart';
import 'package:moxy/ui/screens/admin/pages/create_order/pages/payment.dart';
import 'package:moxy/ui/screens/admin/pages/create_order/pages/status_page.dart';

import '../../../../components/app_indicator.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/loader.dart';
import '../../../../components/snackbar_widgets.dart';
import '../../../../components/succes_card.dart';
import '../../../../../domain/admin/create_order/create_order_cubit.dart';
import '../../../../../domain/admin/create_order/create_order_effects.dart';
import '../../../../../domain/admin/create_order/create_order_state.dart';
import '../../../../theme/app_theme.dart';
import '../create_product/create_product_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class CreateOrderPage extends StatelessWidget {
  const CreateOrderPage();

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = const [About(), Payment(), Delivery(), StatusPage()];
    final CreateOrderCubit cubit = context.read<CreateOrderCubit>();
    cubit.effectStream.listen((effect) {
      if (effect is ValidationFailed) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
            snackBarFailureText: AppLocalizations.of(context)!.wrongInput));
      } else if (effect is FailedCreation) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
            snackBarFailureText:
                AppLocalizations.of(context)!.failedToCreateOrder));
      }
    });

    return BlocConsumer<CreateOrderCubit, CreateOrderState>(
      listener: (context, state) => {},
      builder: (context, state) {
        final cubit = context.read<CreateOrderCubit>();
        return Material(
          color: AppTheme.pink,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return KeyboardVisibilityBuilder(
              builder: (context, isKeyboardVisible) {
                return state.isSuccess
                    ? SuccessCard(
                        onTap: () {
                          if (state.isEdit) {
                            cubit.createNew();
                          } else {
                            cubit.clearState();
                            context.read<AdminHomeRouterCubit>().navigateTo(
                                  const OrdersPageState(),
                                );
                          }
                        },
                        title: AppLocalizations.of(context)!.orderAdded,
                        titleButton: state.isEdit
                            ? AppLocalizations.of(context)!.createNew
                            : AppLocalizations.of(context)!.backToOrder)
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
                                            inadicatorName: [
                                              AppLocalizations.of(context)!
                                                  .about,
                                              AppLocalizations.of(context)!
                                                  .payment,
                                              AppLocalizations.of(context)!
                                                  .delivery,
                                              AppLocalizations.of(context)!
                                                  .status,
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
                              positionOrderButton(
                                  state, cubit, isKeyboardVisible, context)
                            ],
                          );
              },
            );
          }),
        );
      },
    );
  }
}

Widget positionOrderButton(CreateOrderState state, CreateOrderCubit cubit,
    bool isKeyboardVisible, context) {
  double buttonsHeight = isKeyboardVisible ? 0 : bottomButtonsHeight;
  return SizedBox(
      height: buttonsHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          state.activePage != 0
              ? CustomButton(
                  title: AppLocalizations.of(context)!.previusButton,
                  onTap: cubit.moveToPreviustPage,
                  buttonWidth: 150,
                  outline: true,
                )
              : Container(
                  width: 150,
                ),
          CustomButton(
            title: state.activePage != 3
                ? AppLocalizations.of(context)!.nextButton
                : AppLocalizations.of(context)!.addButton,
            onTap: cubit.moveToNextPage,
            buttonWidth: 150,
          )
        ],
      ));
}
