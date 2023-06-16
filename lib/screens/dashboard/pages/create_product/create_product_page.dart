import 'package:bloc_effects/bloc_effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/components/custom_button.dart';
import 'package:moxy/components/snackbar_widgets.dart';
import 'package:moxy/domain/create_product/create_product_cubit.dart';
import 'package:moxy/domain/create_product/create_product_state.dart';
import 'package:moxy/navigation/home_router_cubit.dart';
import 'package:moxy/screens/dashboard/pages/create_product/pages/branding.dart';
import 'package:moxy/screens/dashboard/pages/create_product/pages/details.dart';
import 'package:moxy/theme/app_theme.dart';
import '../../../../components/app_indicator.dart';
import '../../../../components/loader.dart';
import '../../../../components/succes_card.dart';
import '../../../../domain/create_product/create_product_effects.dart';
import '../../../../domain/ui_effect.dart';

// ignore: must_be_immutable
class CreateProductPage extends StatelessWidget {
  bool isEditMode;
  String? editProductId;
  CreateProductPage({
    Key? key,
    required this.isEditMode,
    this.editProductId,
  }) : super(key: key);

  @override
  Widget build(BuildContext mainContext) {
    List<Widget> pages = const [
      ProductDetails(),
      Branding(),
    ];

    return BlocProvider<CreateProductCubit>(
      create: (BuildContext context) =>
          CreateProductCubit(productId: editProductId, isEditMode: isEditMode),
      child:
          BlocEffectListener<CreateProductCubit, UiEffect, CreateProductState>(
        listener: (context, effect, state) {
          if (effect is ValidationFailed) {
            ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
                snackBarFailureText: 'Wrong input, please check text fields.'));
          }
        },
        child: BlocConsumer<CreateProductCubit, CreateProductState>(
          listener: (context, state) => {
            if (state.errorMessage != '')
              {
                ScaffoldMessenger.of(context).showSnackBar(
                    snackBarWhenFailure(snackBarFailureText: 'Failed')),
                context.read<CreateProductCubit>().clearErrorState(),
              }
          },
          builder: (context, state) {
            final cubit = context.read<CreateProductCubit>();
            return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: SizedBox(
                  height: constraints.maxHeight,
                  child: Material(
                    color: AppTheme.pink,
                    child: state.isSuccess
                        ? _buildSuccessWidget(context, cubit, state)
                        : state.isLoading
                            ? loader()
                            : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: AppIndicator(
                                        activePage: state.activePage,
                                        inadicatorName: const ['About', 'Sale'],
                                        pages: const [
                                          ProductDetails(),
                                          Branding()
                                        ],
                                        controller: cubit.pageController),
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
                                        return pages[index % pages.length];
                                      },
                                    ),
                                  )
                                ],
                              ),
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }

  Widget _buildSuccessWidget(BuildContext context, CreateProductCubit cubit,
      CreateProductState state) {
    return succsess(
        onTap: () {
          if (state.isEdit) {
            cubit.clearState();
            context.read<HomeRouterCubit>().navigateTo(
                  const ProductsPageState(),
                );
          } else {
            cubit.createNew();
          }
        },
        title: 'Product Added',
        titleButton: state.isEdit ? 'Back To Product' : 'Create New');
  }
}

Widget positionProductButton(
    CreateProductState state, CreateProductCubit cubit) {
  return Row(
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
        title: state.activePage != 1 ? 'Next' : 'Add',
        onTap: cubit.moveToNextPage,
        buttonWidth: 150,
      )
    ],
  );
}
