import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:moxy/services/navigation/admin_home_router_cubit.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/components/snackbar_widgets.dart';
import 'package:moxy/domain/create_product/create_product_cubit.dart';
import 'package:moxy/domain/create_product/create_product_state.dart';
import 'package:moxy/ui/screens/admin/pages/create_product/pages/branding.dart';
import 'package:moxy/ui/screens/admin/pages/create_product/pages/details.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';
import '../../../../components/app_indicator.dart';
import '../../../../components/loader.dart';
import '../../../../components/succes_card.dart';
import '../../../../../domain/create_product/create_product_effects.dart';

const bottomButtonsHeight = 100.0;

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
    final CreateProductCubit cubit =
        CreateProductCubit(productId: editProductId, isEditMode: isEditMode);
    cubit.effectStream.listen((effect) {
      if (effect is ValidationFailed) {
        ScaffoldMessenger.of(mainContext).showSnackBar(snackBarWhenFailure(
            snackBarFailureText: 'Wrong input, please check text fields.'));
      }
    });
    return BlocProvider<CreateProductCubit>(
      create: (BuildContext context) =>
          CreateProductCubit(productId: editProductId, isEditMode: isEditMode),
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
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return KeyboardVisibilityBuilder(
                  builder: (context, isKeyboardVisible) {
                return SizedBox(
                  height: constraints.maxHeight,
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: isKeyboardVisible
                              ? constraints.maxHeight
                              : constraints.maxHeight - bottomButtonsHeight,
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
                                              inadicatorName: const [
                                                'About',
                                                'Sale'
                                              ],
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
                                              return pages[
                                                  index % pages.length];
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                        ),
                      ),
                      !state.isSuccess
                          ? positionProductButton(
                              state, cubit, isKeyboardVisible)
                          : Container(),
                    ],
                  ),
                );
              });
            }),
          );
        },
      ),
    );
  }

  Widget _buildSuccessWidget(BuildContext context, CreateProductCubit cubit,
      CreateProductState state) {
    return succsess(
        onTap: () {
          if (state.isEdit) {
            cubit.clearState();
            context.read<AdminHomeRouterCubit>().navigateTo(
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

Widget positionProductButton(CreateProductState state, CreateProductCubit cubit,
    bool isKeyboardVisible) {
  double buttonsHeight = isKeyboardVisible ? 0 : bottomButtonsHeight;
  moxyPrint(
      'Buttons height: $buttonsHeight, isKeyboardVisible: $isKeyboardVisible');
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
          title: state.activePage != 1 ? 'Next' : 'Add',
          onTap: cubit.moveToNextPage,
          buttonWidth: 150,
        )
      ],
    ),
  );
}
