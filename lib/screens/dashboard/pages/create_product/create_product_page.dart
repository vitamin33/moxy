import 'package:bloc_effects/bloc_effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/components/snackbar_widgets.dart';
import 'package:moxy/domain/create_product/create_product_cubit.dart';
import 'package:moxy/domain/create_product/create_product_state.dart';
import 'package:moxy/screens/dashboard/pages/create_product/pages/branding.dart';
import 'package:moxy/screens/dashboard/pages/create_product/pages/details.dart';
import 'package:moxy/screens/dashboard/pages/create_product/pages/summary.dart';
import 'package:moxy/theme/app_theme.dart';
import '../../../../components/rounded_card.dart';
import '../../../../domain/create_product/create_product_effects.dart';
import '../../../../domain/ui_effect.dart';

class CreateProductPage extends StatelessWidget {
  const CreateProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = const [
      ProductDetails(),
      Branding(),
      Summary(),
    ];
    return BlocEffectListener<CreateProductCubit, UiEffect, CreateProductState>(
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
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: state.isLoading
                ? loader()
                : Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                                child: Padding(
                                    padding: const EdgeInsets.all(
                                        AppTheme.cardPadding),
                                    child: SizedBox(
                                        width: double.maxFinite,
                                        height: 550,
                                        child: RoundedCard(
                                            padding: const EdgeInsets.all(0),
                                            child: Column(children: [
                                              appIndicator(state, cubit, pages),
                                              Expanded(
                                                child: PageView.builder(
                                                  controller:
                                                      cubit.pageController,
                                                  onPageChanged: (int page) {
                                                    cubit.onChangePage(page);
                                                  },
                                                  itemCount: pages.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return pages[
                                                        index % pages.length];
                                                  },
                                                ),
                                              )
                                            ]))))),
                          ),
                        ],
                      ),
                      positionButton(state, cubit)
                    ],
                  ),
          );
        },
      ),
    );
  }
}

Widget positionButton(CreateProductState state, CreateProductCubit cubit) {
  return Positioned(
    height: 60,
    bottom: 15,
    left: 0,
    right: 0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            cubit.moveToPreviustPage();
          },
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      color: AppTheme.primaryColor,
                      width: 1,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(50)),
              elevation: 50,
              padding: const EdgeInsets.all(28),
              backgroundColor: AppTheme.primaryContainerColor),
          child: const Text('Previus'),
        ),
        TextButton(
          onPressed: () {
            cubit.moveToNextPage();
          },
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      color: AppTheme.primaryColor,
                      width: 1,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(50)),
              padding: const EdgeInsets.all(28),
              backgroundColor: AppTheme.primaryContainerColor),
          child: Text(state.activePage != 2 ? 'Next' : 'Add'),
        ),
      ],
    ),
  );
}

Widget appIndicator(CreateProductState state, CreateProductCubit cubit, pages) {
  return SizedBox(
      height: 50,
      child: Container(
        color: AppTheme.primaryContainerColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(
              pages.length,
              (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                        onTap: () {
                          cubit.pageController.animateToPage(index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        child: CircleAvatar(
                          radius: 6,
                          backgroundColor: state.activePage == index
                              ? Colors.red
                              : AppTheme.secondaryColor,
                        )),
                  )),
        ),
      ));
}

Widget loader() {
  return Column(children: const [
    Expanded(
      child: Padding(
          padding: EdgeInsets.all(AppTheme.cardPadding),
          child: RoundedCard(
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 1.0,
              ),
            ),
          )),
    )
  ]);
}
