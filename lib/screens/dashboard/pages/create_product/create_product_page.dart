import 'package:bloc_effects/bloc_effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/components/custom_button.dart';
import 'package:moxy/components/snackbar_widgets.dart';
import 'package:moxy/domain/create_product/create_product_cubit.dart';
import 'package:moxy/domain/create_product/create_product_state.dart';
import 'package:moxy/screens/dashboard/pages/create_product/pages/branding.dart';
import 'package:moxy/screens/dashboard/pages/create_product/pages/details.dart';
import 'package:moxy/theme/app_theme.dart';
import '../../../../components/dashed_path_painter.dart';
import '../../../../components/rounded_card.dart';
import '../../../../domain/create_product/create_product_effects.dart';
import '../../../../domain/ui_effect.dart';

class CreateProductPage extends StatelessWidget {
  bool isEditMode;
  String? editProductId;
  CreateProductPage({
    Key? key,
    required this.isEditMode,
    this.editProductId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            return Material(
              color: AppTheme.pink,
              child: state.isLoading
                  ? loader()
                  : Container(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: SizedBox(
                                    width: double.maxFinite,
                                    height: 550,
                                    child: Column(
                                      children: [
                                        appIndicator(
                                            state, cubit, pages, context),
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
                    ),
            );
          },
        ),
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
        state.activePage == 1
            ? CutomButton(
                title: 'Previus',
                onTap: cubit.moveToPreviustPage,
                buttonWidth: 150,
              )
            : Container(),
        CutomButton(
          title: state.activePage != 1 ? 'Next' : 'Add',
          onTap: cubit.moveToNextPage,
          buttonWidth: 150,
        )
      ],
    ),
  );
}

Widget appIndicator(
    CreateProductState state, CreateProductCubit cubit, pages, context) {
  List<String> indicatorName = const ['About', 'Sale'];
  return Stack(children: [
    SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 42.0, top: 15),
            child: CustomPaint(
              painter: DashedPathPainter(
                originalPath: Path()..lineTo(330, 0),
                pathColor: Colors.grey,
                strokeWidth: 2.0,
                dashGapLength: 5.0,
                dashLength: 5.0,
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List<Widget>.generate(
            pages.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Radio(
                      focusColor: AppTheme.pinkDark,
                      activeColor: AppTheme.black,
                      value: index,
                      groupValue: state.activePage,
                      onChanged: (value) {
                        cubit.pageController.animateToPage(index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      }),
                  Text(
                    indicatorName[index],
                    style: TextStyle(
                        color: state.activePage == index
                            ? AppTheme.black
                            : AppTheme.gray),
                  )
                ],
              ),
            ),
          ),
        )),
  ]);
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
